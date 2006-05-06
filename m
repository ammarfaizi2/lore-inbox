Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751813AbWEFEDW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751813AbWEFEDW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 May 2006 00:03:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751816AbWEFEDW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 May 2006 00:03:22 -0400
Received: from ms-smtp-03.socal.rr.com ([66.75.162.135]:36277 "EHLO
	ms-smtp-03.socal.rr.com") by vger.kernel.org with ESMTP
	id S1751813AbWEFEDW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 May 2006 00:03:22 -0400
Message-Id: <6.2.3.4.0.20060505204729.036dfdf8@pop-server.san.rr.com>
X-Mailer: QUALCOMM Windows Eudora Version 6.2.3.4
Date: Fri, 05 May 2006 20:57:48 -0700
To: "H. Peter Anvin" <hpa@zytor.com>
From: John Coffman <johninsd@san.rr.com>
Subject: Re: [PATCH][TAKE 4] THE LINUX/I386 BOOT PROTOCOL - Breaking  
  the 256 limit
Cc: Alon Bar-Lev <alon.barlev@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Barry K. Nathan" <barryn@pobox.com>, Adrian Bunk <bunk@fs.tum.de>,
       tony.luck@intel.com
In-Reply-To: <445BCA33.30903@zytor.com>
References: <445B5524.2090001@gmail.com>
 <445B5C92.5070401@zytor.com>
 <445B610A.7020009@gmail.com>
 <445B62AC.90600@zytor.com>
 <6.2.3.4.0.20060505110517.036df928@pop-server.san.rr.com>
 <445B96D2.9070301@zytor.com>
 <6.2.3.4.0.20060505144445.03642988@pop-server.san.rr.com>
 <445BCA33.30903@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-Antivirus: avast! (VPS 0618-3, 05/05/2006), Outbound message
X-Antivirus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 02:57 PM  Friday 5/5/2006, H. Peter Anvin wrote:
Okay, let me ask this:

>If the *kernel* limit is modified, but the LILO limit is not, what 
>will happen?  This is the real crux of the matter.

The length of the kernel command line will be limited by the size of 
the boot loader buffer.  LILO always inserts a NUL terminator.

--John

P.S.  The LILO command line buffer has always been 1 sector (512 
bytes); however, only the first half is actually used for the command 
line. No kernel can do any harm by setting "boot_cmdline[511] = 0;" 
for any version of LILO back to version 20 (and probably before).



         PGP KeyID: 6781C9C8  (good until 31-Dec-2008)
         Keyserver at  ldap://keyserver.pgp.com  OR  http://pgp.mit.edu
         LILO links at http://freshmeat.net/projects/lilo
         and Help link at http://lilo.go.dyndns.org


