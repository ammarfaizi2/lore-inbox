Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262262AbRFLQSG>; Tue, 12 Jun 2001 12:18:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262445AbRFLQR4>; Tue, 12 Jun 2001 12:17:56 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:13834 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262262AbRFLQRq>; Tue, 12 Jun 2001 12:17:46 -0400
Subject: Re: [PATCH] megaraid.c
To: praveens@stanford.edu (Praveen Srinivasan)
Date: Tue, 12 Jun 2001 17:16:04 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com,
        alan@lxorguk.ukuu.org.uk
In-Reply-To: <200106120605.f5C65f402129@smtp1.Stanford.EDU> from "Praveen Srinivasan" at Jun 11, 2001 11:05:46 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E159qpo-0001Yp-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This patch fixes an instance where an allocation is checked, but only after 
> the pointer is memset() - moving the memset further down in the function 
> fixes this.

There are a ton of these in the scsi code in Linus tree, Im still merging them
please grab the -ac patch before you waste time on this - there are about
30 or 40 of these already fixed.

The SCSI one is _much_ more problematic because there are pieces of quite high
level code that blindly assumed a scsi command alloc always works etc..
