Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266749AbRGFVqF>; Fri, 6 Jul 2001 17:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266752AbRGFVpz>; Fri, 6 Jul 2001 17:45:55 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:52486 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S266749AbRGFVpt>; Fri, 6 Jul 2001 17:45:49 -0400
Subject: Re: BIGMEM kernel question
To: anderson@centtech.com
Date: Fri, 6 Jul 2001 22:46:16 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <3B462AA8.F7F0089D@centtech.com> from "Eric Anderson" at Jul 06, 2001 04:16:24 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15IdQW-0004zi-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ahh. That makes sense.  So how can I change the chunk size from 64k to
> something higher (I assume I could set it to 128k to effectively double
> that 3GB to 6GB)?  

I think you misunderstand. If you want more than 3Gb you will have to map and
unmap stuff yourself. You only have 3Gb of per process address space due to
x86 weaknesses (lack of seperate kernel/user spaces without tlb flush
overhead nightmares)

