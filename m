Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262702AbREVSQj>; Tue, 22 May 2001 14:16:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262699AbREVSQ2>; Tue, 22 May 2001 14:16:28 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:36370 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262702AbREVSQP>; Tue, 22 May 2001 14:16:15 -0400
Subject: Re: why DMAable memory restriction ?
To: hiren_mehta@agilent.com
Date: Tue, 22 May 2001 19:13:36 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <FEEBE78C8360D411ACFD00D0B7477971880A7F@xsj02.sjs.agilent.com> from "hiren_mehta@agilent.com" at May 22, 2001 11:41:12 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E152Gf2-0002H6-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In the linux kernel there is a limitation on the
> amount of contiguous DMAable memory that can be allocated
> (I guess about 128K). Does anobody know what is the reason

128K or so , if you are lucky. 

> for such a restriction ? Is there any plan to remove

Because the pages are contiguous so you have to find a suitable sized piece
of free memory

> this restriction in the future releases of kernel ?

Nope. 2.4 adds bootmem though so badly designed hardware that is compiled in
can grab memory early in biggish chunks.

