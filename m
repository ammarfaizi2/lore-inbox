Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263097AbVCXPun@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263097AbVCXPun (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 10:50:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263103AbVCXPr2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 10:47:28 -0500
Received: from users.linvision.com ([62.58.92.114]:52105 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S262847AbVCXPnY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 10:43:24 -0500
Date: Thu, 24 Mar 2005 16:43:17 +0100
From: Erik Mouw <erik@harddisk-recovery.com>
To: govind raj <agovinda04@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel crash problem and Madwifi
Message-ID: <20050324154317.GK7016@harddisk-recovery.com>
References: <BAY10-F346FCB94AAE3D59115210D6400@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BAY10-F346FCB94AAE3D59115210D6400@phx.gbl>
User-Agent: Mutt/1.3.28i
Organization: Harddisk-recovery.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2005 at 08:35:49PM +0530, govind raj wrote:
> kernel version:2.4.29
> board :net4521
> wireless card : Atheros-5212
> diriver  madwifi-cvs-current.tar.bz2(v 1.30 2005/02/22)

According to the FAQ at http://www.mattfoster.clara.co.uk/madwifi-1.htm#2 ,
Madwifi is based on a binary-only module.

> I built the customized image  from 2.4.29 and  booted from this image

[...]

> Unable to handle kernel paging request at virtual address e49aac30
> printing eip:
> c4878019
> *pde = 00000000
> Oops: 0000
> CPU:    0
> EIP:    0010:[<c4878019>]    Tainted: P

Yes, tainted by a proprietary licensed module. Sorry, lkml is not able
to help you with binary-only modules. Ask whoever supplied your driver
for support.

> EFLAGS: 00010246
> eax: 0804ab74   ebx: c3d76000   ecx: 00000000   edx: 00000000
> esi: c3d76000   edi: c3d76348   ebp: c3d76000   esp: c3c09ed0
> ds: 0018   es: 0018   ss: 0018
> Process ifconfig (pid: 116, stackpage=c3c09000)
> Stack: 0804ab74 c3d7615c 00000000 c3c54000 0804ab74 c3d76000 00000000 
> 00001043
>      00000000 c01a5484 c3d76000 c3d76000 00001002 c01a66c1 c3d76000 
> c3c09f54
>      c3c09f59 c3c2b144 bffffa10 c01dd219 c3d76000 00001043 00000000 
> 00000000
> Call Trace:    [<c01a5484>] [<c01a66c1>] [<c01dd219>] [<c019eeca>] 
> [<c014163e>]
> [<c0106dc3>]

Next time run the oops through ksymoops. Undecoded oopses are almost
useless.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
