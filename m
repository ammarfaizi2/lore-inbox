Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934295AbWKTSHp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934295AbWKTSHp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 13:07:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934290AbWKTSHM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 13:07:12 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:48071 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S934273AbWKTSG7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 13:06:59 -0500
Date: Mon, 20 Nov 2006 18:12:27 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: avl@logic.at
Cc: linux-kernel@vger.kernel.org
Subject: Re: possible bug in ide-disk.c (2.6.18.2 but also older)
Message-ID: <20061120181227.27847d67@localhost.localdomain>
In-Reply-To: <20061120175721.GT6851@gamma.logic.tuwien.ac.at>
References: <20061120145148.GQ6851@gamma.logic.tuwien.ac.at>
	<20061120152505.5d0ba6c5@localhost.localdomain>
	<20061120165601.GS6851@gamma.logic.tuwien.ac.at>
	<20061120172812.64837a0a@localhost.localdomain>
	<20061120175721.GT6851@gamma.logic.tuwien.ac.at>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Nov 2006 18:57:21 +0100
Andreas Leitgeb <avl@logic.at> wrote:
> To me it now seems that my symptoms have twofold cause:
>   -) misinterpretation of that drive's reported number of sectors.

The current code appears correct.

>   -) accessing the last reported sector in search for a GPT.

The partition code triggers a 1K read for the last 512 bytes of the disk.
This breaks.
