Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129066AbRBTU7L>; Tue, 20 Feb 2001 15:59:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129069AbRBTU7B>; Tue, 20 Feb 2001 15:59:01 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:3846 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129066AbRBTU6t>; Tue, 20 Feb 2001 15:58:49 -0500
Subject: Re: can somebody explain barrier() macro ?
To: hiren_mehta@agilent.com
Date: Tue, 20 Feb 2001 21:02:09 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <FEEBE78C8360D411ACFD00D0B74779718809AB@xsj02.sjs.agilent.com> from "hiren_mehta@agilent.com" at Feb 20, 2001 12:50:54 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14VJvH-0000gc-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> barrier() is defined in kernel.h as follows :
> 
> #define barrier() __asm__ __volatile__("": : :"memory")
> 
> what does this mean ? is this like "nop" ?

Its adds an empty piece of assembler (ie no code) and declares that this
non code causes effects on memory. That forces gcc to writeback before the
barrier and reload cached values afterwards
