Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270724AbRH1LH7>; Tue, 28 Aug 2001 07:07:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270746AbRH1LHu>; Tue, 28 Aug 2001 07:07:50 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:5134 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S270724AbRH1LHj>; Tue, 28 Aug 2001 07:07:39 -0400
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
To: torvalds@transmeta.com (Linus Torvalds)
Date: Tue, 28 Aug 2001 12:10:12 +0100 (BST)
Cc: viro@math.psu.edu (Alexander Viro), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0108272231290.8067-100000@penguin.transmeta.com> from "Linus Torvalds" at Aug 27, 2001 10:51:05 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15bgl2-0005oW-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Or, with the 2.4.9 approach, it's just a single macro (well, and another
> one for "max()"). And when somebody needs a new type, he doesn't have to
> worry about creating a new instantiation of the macro.

The unfortunate thing is that its min and max as opposed to typed_min and
typed_max (with min/max set up to error), since its now a nightmare to 
maintain compatibility between two allegedly stable releases of the same
kernel, as well as with 2.2

Had it been typed_min(a,b,c) then 2.2 could have stayed compatible and the
glue would have been simple
