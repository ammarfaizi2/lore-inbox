Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266890AbRGHOAP>; Sun, 8 Jul 2001 10:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266893AbRGHOAG>; Sun, 8 Jul 2001 10:00:06 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:38929 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S266890AbRGHN75>; Sun, 8 Jul 2001 09:59:57 -0400
Subject: Re: Machine check exception? (2.4.6+SMP+VIA)
To: cw@f00f.org (Chris Wedgwood)
Date: Sun, 8 Jul 2001 15:00:22 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), vhou@khmer.cc (Vibol Hou),
        linux-kernel@vger.kernel.org (Linux-Kernel)
In-Reply-To: <20010708192805.C26213@weta.f00f.org> from "Chris Wedgwood" at Jul 08, 2001 07:28:05 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15JF6k-0000AI-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is there any reason why, with proper MCE checking for both K7 and PIII
> we can't automatically off-line processors when they start doing bad
> things?

Architectural limitations. Its entirely possible that the cache of the dying
processor contains exclusive copies of arbitary data.

> Also, I'm pretty sure I was seeing overheating problems or something
> on a K7 at one point, but never saw MCE; I take it this code only
> exists fully in -ac kernels? I looked in Linus' tree and couldn't see
> anything.

Only -ac has K7 MCE enabled right now - also MCE is not guaranteed to catch
problems.

