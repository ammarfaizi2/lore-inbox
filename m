Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129370AbQLKI6Y>; Mon, 11 Dec 2000 03:58:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130024AbQLKI6O>; Mon, 11 Dec 2000 03:58:14 -0500
Received: from arctica.sime.com ([193.228.80.12]:45324 "EHLO arctica.sime.com")
	by vger.kernel.org with ESMTP id <S129700AbQLKI57>;
	Mon, 11 Dec 2000 03:57:59 -0500
From: "Martin Bene" <mb-lists01@sime.com>
To: "Ryan Barnett" <rbarnett@usc.edu>, <linux-kernel@vger.kernel.org>
Subject: AW: Got "VM: do_try_to_free_pages failed for xyz" in 2.2.18pre27
Date: Mon, 11 Dec 2000 09:23:37 +0100
Message-ID: <NEBBJLJOCDIPKEENFGGCIEOJGGAA.mb-lists01@sime.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <Pine.GSO.4.21.0012100943380.19986-100000@aludra.usc.edu>
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ryan,

> This is notice that the do_try_to_free_pages bug is still present in the
> latest 2.2 kernel, 2.2.18pre27.
>
> VM: do_try_to_free_pages failed for kjournald...
> VM: do_try_to_free_pages failed for kjournald...
> VM: do_try_to_free_pages failed for kjournald...
>
> The error also occurs for other processes running on the system.  This was
> a test with ext3.
>
> The bug triggers when the system is really hammered (high system, network,
> and disk load), and requires a reboot to recover.

In case you haven't done so after trying 2.2.18pre27 and finding the VM bug
still present: grab and apply andreas VM-global patch, it should fix the
problem.

ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.2/2.2.18pr
e25/VM-global-2.2.18pre25-7.bz2

Bye, Martin

"you have moved your mouse, please reboot to make this change take effect"
--------------------------------------------------
 Martin Bene               vox: +43-316-813824
 simon media               fax: +43-316-813824-6
 Nikolaiplatz 4            e-mail: mb@sime.com
 8020 Graz, Austria
--------------------------------------------------
finger mb@mail.sime.com for PGP public key

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
