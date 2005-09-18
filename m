Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932069AbVIROVl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbVIROVl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 10:21:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932070AbVIROVl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 10:21:41 -0400
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36]:49504 "HELO
	smtp005.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932069AbVIROVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 10:21:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:MIME-Version:Content-Disposition:Message-Id:Content-Type:Content-Transfer-Encoding;
  b=ELbyzRXVdr/7hj+1b4joMga5AVrjaDZ3NGkRD1K4hk+rXkFIpTDcDKn/USbbz0UIkqmI5Hnt5YTBw7T8mTQPGAEew4Osb2Q4Mgjc0jfax4vzsAwepUz1RnT453v74jTO8i11Ddx6B3BgWycqRnOqyqvY0OP1m2FrIFDsCRsY/pc=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: Antoine Martin <antoine@nagafix.co.uk>, Al Viro <viro@zeniv.linux.org.uk>
Subject: Fixing HPPFS
Date: Sun, 18 Sep 2005 14:00:38 +0200
User-Agent: KMail/1.8.1
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net,
       LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200509181400.39120.blaisorblade@yahoo.it>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, while I was updating hppfs for other things and Al Viro read my patch, he 
went in "Let's check what's left" mode, and discovered a fair amount of crap, 
and requested to fix it - which I've been doing until now.

While looking at it, I also discovered some Oopses fixed in 2.4 and not in 
2.6, and forward ported something else while I was at it.

However, I also had an unconfirmed report from Antoine of some regressions in 
2.6 wrt 2.4 - not better specified, he also talked of a wrong setup so I 
don't know if in the end everything was fixed.

So, I'd like to get these patches reviewed on one side, and tested (from 
Antoine) on the other. When testing, please exclude for now the last patch - 
it's likely to cause more problem than it potentially solves, until reviewed.

Wrapping another FS is funny enough, it seems - especially as no file system 
knows some VFS details, which seem to be totally undocumented.

The code, currently, is totally untested (apart that it compiles).

It seems that the use is simply:

perl honeypot.pl <dir>
it creates <dir>/proc
<run Uml with dir as current directory>
<mount hppfs in /proc>

Ok, nice. I'm going to try it, when I find time (for now I didn't).
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade


	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
