Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264342AbTKMQiS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 11:38:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264348AbTKMQiS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 11:38:18 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:36742 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S264342AbTKMQiQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 11:38:16 -0500
X-AuthUser: davidel@xmailserver.org
Date: Thu, 13 Nov 2003 08:37:25 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Roland Lezuo <roland.lezuo@chello.at>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.23-rc1: SiS pirq: IDE/ACPI/DAQ mapping not implemented: (97)
In-Reply-To: <200311131250.42465.roland.lezuo@chello.at>
Message-ID: <Pine.LNX.4.44.0311130833480.1809-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Nov 2003, Roland Lezuo wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hello,
> 
> on my Sis 745 Chipset neither psaux nor USB is working as it should. I can 
> only use serial mice on this box.
> 
> <from dmesg>
> SiS pirq: IDE/ACPI/DAQ mapping not implemented: (97)
> SiS router unknown request: (97)
> SiS pirq: IDE/ACPI/DAQ mapping not implemented: (97)
> SiS router unknown request: (97)
> 
> I though the patch has already been merged?

The latest CVS snapshot I was able to rsync from kernel.org had the fix 
and should make it work:

[root@drizzle src]# head linux-2.4/Makefile
VERSION = 2
PATCHLEVEL = 4
SUBLEVEL = 23
EXTRAVERSION = -pre9

Request 97 is one of the new ones (USB) correctly handled by the patch.



- Davide


