Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261665AbSJYXSl>; Fri, 25 Oct 2002 19:18:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261677AbSJYXSl>; Fri, 25 Oct 2002 19:18:41 -0400
Received: from petasus.ch.intel.com ([143.182.124.5]:31663 "EHLO
	petasus.ch.intel.com") by vger.kernel.org with ESMTP
	id <S261665AbSJYXSk>; Fri, 25 Oct 2002 19:18:40 -0400
Message-ID: <F2DBA543B89AD51184B600508B68D4000ECE70AE@fmsmsx103.fm.intel.com>
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Robert Love <rml@tech9.net>, Daniel Phillips <phillips@arcor.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "'Dave Jones'" <davej@codemonkey.org.uk>,
       "'akpm@digeo.com'" <akpm@digeo.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'chrisl@vmware.com'" <chrisl@vmware.com>,
       "'Martin J. Bligh'" <mbligh@aracnet.com>
Subject: RE: [PATCH] hyper-threading information in /proc/cpuinfo
Date: Fri, 25 Oct 2002 16:24:45 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No, the notion of "sibling" is not clear. The other day a person pointed out
"the number of the siblings does not include yourself" when she saw the
variable smp_num_siblings. So with HT enabled, for a cpu the number of the
siblings should be 1, instead of 2, from an English language perspective.
But we want to mean the number H/W threads in a processor package. 

And with multi-core, "sibling" is not clear enough to distiguish "core" in a
processor package and "thread" in a "core".

Jun
-----Original Message-----
From: Jeff Garzik [mailto:jgarzik@pobox.com]
Sent: Friday, October 25, 2002 3:58 PM
To: Nakajima, Jun
Cc: Robert Love; Daniel Phillips; Alan Cox; 'Dave Jones';
'akpm@digeo.com'; 'linux-kernel@vger.kernel.org'; 'chrisl@vmware.com';
'Martin J. Bligh'
Subject: Re: [PATCH] hyper-threading information in /proc/cpuinfo


Nakajima, Jun wrote:

>The notion of "SMT (Simultaneous Multi-Threaded)" architecture has been
>there for a while (at least 8 years, as far as I know). You would get tons
>of info if you search it in Internet. 
>  
>


Certainly.   That however does not imply that Robert's patch should read 
"number of threads" instead of "number of siblings."  The lone word 
"thread" does not automatically imply "active thread running on this 
virtual processor" or anything close to that.

"sibling" makes a lot more sense from an English language perspective.

    Jeff



