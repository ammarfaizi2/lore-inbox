Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270661AbRH1LE3>; Tue, 28 Aug 2001 07:04:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270724AbRH1LEU>; Tue, 28 Aug 2001 07:04:20 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:1550 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S270661AbRH1LEH>; Tue, 28 Aug 2001 07:04:07 -0400
Subject: Re: Workaround for VIA chipset+ATAPI ZIP 100 problem
To: timo.teras@votek.com (Timo Teras)
Date: Tue, 28 Aug 2001 12:07:15 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, mihaim@profm.ro, stepan@srnet.cz
In-Reply-To: <3B8B4050.7778F59A@votek.com> from "Timo Teras" at Aug 28, 2001 09:55:12 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15bgiB-0005o0-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +	if (floppy->via_kludge) {
> +		long wait = floppy->via_kludge - jiffies;

that will do strange things when the timer wraps. Use unsigned and
"time_before"

As to the rest perhaps Andre can comment
