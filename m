Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284034AbRLAJpm>; Sat, 1 Dec 2001 04:45:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284036AbRLAJpc>; Sat, 1 Dec 2001 04:45:32 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:50440 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S284034AbRLAJpY>; Sat, 1 Dec 2001 04:45:24 -0500
Subject: Re: [PATCH] remove BKL from drivers' release functions
To: ricklind@us.ibm.com (Rick Lindsley)
Date: Sat, 1 Dec 2001 09:52:57 +0000 (GMT)
Cc: viro@math.psu.edu (Alexander Viro), dave@sr71.net (David C. Hansen),
        alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <200112010047.fB10lA406654@eng4.beaverton.ibm.com> from "Rick Lindsley" at Nov 30, 2001 04:47:10 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16A6pN-0006d0-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> opens, we CAN announce we are closer, and nothing else will be any more
> broken than it was before we started. As I said in an earlier post (and
> I don't think anybody disagrees): this is an incremental task. Any

This is why we have a development tree. Its moving things in the right
direction which is important. I suspect many drivers will want to use
semaphores rather than atomic counts however, to ensure that an open doesn't
complete while a previous release is still shutting down hardware

Alan

