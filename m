Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261349AbVAGLub@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261349AbVAGLub (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 06:50:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261350AbVAGLub
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 06:50:31 -0500
Received: from web51510.mail.yahoo.com ([206.190.38.202]:28049 "HELO
	web51510.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261349AbVAGLuL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 06:50:11 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=vFJxawK50b/eHwKxpqUoiSHNq82Nu28KGJvC00nHzxdajOe/mFOu9sxORYIvyGFfwBPJCvuBTce2ePZSaueig904qtOXXQt+81LydWOuExaubnuXJhdN0D4b/jHs6SR6bkdy0tRPEtHXTVCYyAaV31zLjuzodoWEXMsS8KhYqVQ=  ;
Message-ID: <20050107115011.24897.qmail@web51510.mail.yahoo.com>
Date: Fri, 7 Jan 2005 03:50:11 -0800 (PST)
From: Park Lee <parklee_sel@yahoo.com>
Subject: How to understand and turn off such a oops
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  Sometimes, when I call kmalloc() in Linux kernel,
the kernel always bring out a oops shown as following:


Debug: sleeping function called from invalid context
at mm/slab.c:1980
in_atomic():1, irqs_disabled():0
Call Trace: [<0211691d>]  [<02130a17>]  [<02189857>] 
[<021837a6>]  [<02294651>]  [<02118840>]  [<021189cd>]
 [<02263e84>]  [<0227a3e4>]  [<0227a465>] 
[<0227a953>]  [<0218befb>]  [<0218bc23>]  [<02194118>]
 [<0218d90d>]  [<0218c25f>]  [<0218b132>] 
[<021894f4>]  [<021895f5>]  [<0217f686>]  [<0217f728>]
 [<021835ff>]
[<0227ac21>]  [<0227452a>]  [<0227af39>]  [<0227b3cd>]
 [<02264f19>]  [<022652e7>]  [<02253332>] 
[<1195048f>]  [<119506af>]  [<02253495>]  [<0211af6d>]
 [<021078b1>]  =======================
 [<02107337>]  [<118aeb59>]  [<118aefba>] 
[<118adab2>]  [<02116b21>]  [<02116b21>]  [<022a2301>]
 [<02115ed2>]  [<118afbfe>]  [<02116b21>] 
[<02116b21>]  [<118afb58>]  [<118afb5e>]  [<021041cd>]


  After I transform it with ksymoops, it looks like
this:


ksymoops 2.4.9 on i686 2.6.5-1.358custom.  Options
used
     -V (default)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.6.5-1.358custom/ (default)
     -m /boot/System.map (specified)

No modules in ksyms, skipping objects
Call Trace: [<0211691d>]  [<02130a17>]  [<02189857>] 
[<021837a6>]  [<02294651>]  [<02118840>]  [<021189cd>]
 [<02263e84>]  [<0227a3e4>]  [<0227a465>] 
[<0227a953>]  [<0218befb>]  [<0218bc23>]  [<02194118>]
 [<0218d90d>]  [<0218c25f>]  [<0218b132>] 
[<021894f4>]  [<021895f5>]  [<0217f686>]  [<0217f728>]
 [<021835ff>]
[<0227ac21>]  [<0227452a>]  [<0227af39>]  [<0227b3cd>]
 [<02264f19>]  [<022652e7>]  [<02253332>] 
[<1195048f>]  [<119506af>]  [<02253495>]  [<0211af6d>]
 [<021078b1>]  =======================
 [<02107337>]  [<118aeb59>]  [<118aefba>] 
[<118adab2>]  [<02116b21>]  [<02116b21>]  [<022a2301>]
 [<02115ed2>]  [<118afbfe>]  [<02116b21>] 
[<02116b21>]  [<118afb58>]  [<118afb5e>]  [<021041cd>]
Warning (Oops_read): Code line not seen, dumping what
data is available

Trace; 0211691d <__might_sleep+80/8a>
Trace; 02130a17 <__kmalloc+40/76>
... ...


  Would you please tell me how to understand and solve
such a oops ?
  And, though the kernel brings out such a oops, it
can continue to work(i.e. it doesn't crash). Then, can
I simply ignore such a oops, and go on with my work?
if it is, how/where to trun off such a oops (i.e.
ignore this oops, and don't let the kernel send out
such a oops, thought there surely are something
wrong)?  

  Thank you very much.

=====
Best Regards,
Park Lee


		
__________________________________ 
Do you Yahoo!? 
All your favorites on one personal page – Try My Yahoo!
http://my.yahoo.com 
