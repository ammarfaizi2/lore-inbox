Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751190AbWEESOE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190AbWEESOE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 14:14:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751195AbWEESOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 14:14:04 -0400
Received: from ms-smtp-04.socal.rr.com ([66.75.162.136]:35770 "EHLO
	ms-smtp-04.socal.rr.com") by vger.kernel.org with ESMTP
	id S1751190AbWEESOC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 14:14:02 -0400
Message-Id: <6.2.3.4.0.20060505110517.036df928@pop-server.san.rr.com>
X-Mailer: QUALCOMM Windows Eudora Version 6.2.3.4
Date: Fri, 05 May 2006 11:10:09 -0700
To: "H. Peter Anvin" <hpa@zytor.com>
From: John Coffman <johninsd@san.rr.com>
Subject: Re: [PATCH][TAKE 4] THE LINUX/I386 BOOT PROTOCOL - Breaking
  the 256 limit
Cc: Alon Bar-Lev <alon.barlev@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Barry K. Nathan" <barryn@pobox.com>, Adrian Bunk <bunk@fs.tum.de>,
       Riley@Williams.Name, tony.luck@intel.com, johninsd@san.rr.com
In-Reply-To: <445B62AC.90600@zytor.com>
References: <445B5524.2090001@gmail.com>
 <445B5C92.5070401@zytor.com>
 <445B610A.7020009@gmail.com>
 <445B62AC.90600@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-Antivirus: avast! (VPS 0618-3, 05/05/2006), Outbound message
X-Antivirus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It is probably fairly easy to increase the LILO command line to 512 
bytes (including terminator).  Beyond 512 there are complicating factors:

1.  "lilo -R ..." -- the space reserved for the stored command line 
is 1 sector.
2.  configuration option "fallback" -- again 1 sector is the amount reserved.

There are 2 buffers used for the command line.  Since these are 
allocated on sector boundaries, 512 should present no serious problems.

--John


At 07:35 AM  Friday 5/5/2006, H. Peter Anvin wrote:
>Alon Bar-Lev wrote:
>>This should be a simple modification and I don't see why we
>>should fight on the LILO problem (if exists) when we have
>>the compile time config options alternative.
>>People who uses LILO may leave the default 256 value. Other
>>may migrate to a higher one.
>
>This is cargo-cult programming, sorry.  Let's find out what the 
>problem is and fix it right.  If that involves fixing LILO and/or 
>dealing with a LILO bug, we have ways we can do that.
>
>         -hpa


         PGP KeyID: 6781C9C8  (good until 31-Dec-2008)
         Keyserver at  ldap://keyserver.pgp.com  OR  http://pgp.mit.edu
         LILO links at http://freshmeat.net/projects/lilo
         and Help link at http://lilo.go.dyndns.org


