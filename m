Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132533AbRDEAB6>; Wed, 4 Apr 2001 20:01:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132534AbRDEABs>; Wed, 4 Apr 2001 20:01:48 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:64272 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132533AbRDEABa>; Wed, 4 Apr 2001 20:01:30 -0400
Subject: Re: vmalloc on 2.4.x on ia64
To: hiren_mehta@agilent.com
Date: Thu, 5 Apr 2001 01:03:05 +0100 (BST)
Cc: Matt_Domsch@Dell.com, linux-kernel@vger.kernel.org
In-Reply-To: <FEEBE78C8360D411ACFD00D0B7477971880A07@xsj02.sjs.agilent.com> from "hiren_mehta@agilent.com" at Apr 04, 2001 05:44:25 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14kxEy-00032i-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Can we call vmalloc() or get_free_pages() from scsi low-level driver 
> (HBA driver) ? The reason why I am asking is because, I am calling

It depends where. You can call it during initialisation if you arent holding
the io_request_lock for example.

