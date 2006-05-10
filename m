Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751508AbWEJUDw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751508AbWEJUDw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 16:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751509AbWEJUDw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 16:03:52 -0400
Received: from ppsw-1.csi.cam.ac.uk ([131.111.8.131]:7585 "EHLO
	ppsw-1.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1751508AbWEJUDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 16:03:51 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Wed, 10 May 2006 21:03:48 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Joshua Hudson <joshudson@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Not mounting NTFS rw, 2.6.16.1, but does so on 2.6.15
In-Reply-To: <bda6d13a0605101219k2765533cvb064ba21b58208d3@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0605102100120.7334@hermes-1.csi.cam.ac.uk>
References: <bda6d13a0605092320y5cca6e1co2228f52c9777c3b1@mail.gmail.com> 
 <Pine.LNX.4.64.0605100957040.28166@hermes-1.csi.cam.ac.uk> 
 <bda6d13a0605100924u12270e3dh5f6b519ee0d0b14f@mail.gmail.com> 
 <Pine.LNX.4.64.0605101937170.32568@hermes-1.csi.cam.ac.uk>
 <bda6d13a0605101219k2765533cvb064ba21b58208d3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 May 2006, Joshua Hudson wrote:
> That worked. Funny, windows didn't reboot after running chkdsk during
> boot. It just proceeded streight to the logon screen.

Cool.  Yes, that means it did not change anything major.  Probably the 
only thing it did was to determine the volume was ok and the "chkdsk in 
progress" flag got then cleared and made Linux NTFS happy.

The driver used to ignore this flag but it now checks it.

This flag being set can mean that there is some serious inconcistency on 
disk (it can even mean that chkdsk crashed half-way through or the 
user rebooted the machine during a chkdsk) which is why we check it now...

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer, http://www.linux-ntfs.org/
