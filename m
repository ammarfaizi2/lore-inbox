Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263266AbRFEG7F>; Tue, 5 Jun 2001 02:59:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263267AbRFEG6p>; Tue, 5 Jun 2001 02:58:45 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:17936 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263266AbRFEG6l>; Tue, 5 Jun 2001 02:58:41 -0400
Subject: Re: [PATCH] fs/devfs/base.c
To: hpa@zytor.com (H. Peter Anvin)
Date: Tue, 5 Jun 2001 07:56:37 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <9fht4j$cce$1@cesium.transmeta.com> from "H. Peter Anvin" at Jun 04, 2001 11:10:27 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E157AlZ-0006Vi-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It's trivial to calculate for DAGs -- directed acyclic graphs.  It's
> when the "acyclic" constraint is violated that you have problems!

It may well be that interrupt stacks are a win anyway. If we can get the kernel
struct out of the stack pages (which would fix some very unpleasant cache
colour problems) and take the non irq stack down to 4K then irq stacks would
pay off once you had 25 or so processes on a system
