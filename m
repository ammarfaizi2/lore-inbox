Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263299AbTKKSiB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 13:38:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263747AbTKKSiB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 13:38:01 -0500
Received: from tiere.net.avaya.com ([198.152.12.100]:51074 "EHLO
	tiere.net.avaya.com") by vger.kernel.org with ESMTP id S263299AbTKKShn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 13:37:43 -0500
From: "Bhavesh P. Davda" <bhavesh@avaya.com>
To: <linux-kernel@vger.kernel.org>
Subject: elf_core_dump and kernel virtual mapping (kmap) in 2.4
Date: Tue, 11 Nov 2003 11:37:36 -0700
Message-ID: <PHENKAOAAKGFGBKFJPGBOENJCAAA.bhavesh@avaya.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
X-OriginalArrivalTime: 11 Nov 2003 18:37:36.0476 (UTC) FILETIME=[E0A6F9C0:01C3A882]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folks,

I have been trying to figure out an answer for this, but couldn't find
anything in the lkml archives or in bitkeeper changeset logs on why this is
done:

Why does the kernel have to re-map process virtual memory into it's address
space using get_user_pages() and kmap() when dumping core (elf_core_dump)?
Isn't  the kernel running in the context of the task for which it is dumping
core (current)? And thereby, aren't the kernel's VM mappings the same as the
task it is dumping core for? So the page directory and page table entries
should all still be valid in kernel space. And page faults, if any, should
be handled "correctly", right?

What am I missing here? What's the need for the get_user_pages() and kmap()
in elf_core_dump()?

Thanks
- Bhavesh

--
Bhavesh P. Davda     E-mail    : bhavesh@avaya.com
Avaya Inc.           Phone/Fax : (303) 538-4438
Room B3-B03, 1300 West 120th Avenue
Westminster, CO 80234

