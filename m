Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271937AbRHXPP7>; Fri, 24 Aug 2001 11:15:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272114AbRHXPPs>; Fri, 24 Aug 2001 11:15:48 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:24081 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271937AbRHXPPh>; Fri, 24 Aug 2001 11:15:37 -0400
Subject: Re: [PATCH] const initdata.
To: afu@fugmann.dhs.org (Anders Peter Fugmann)
Date: Fri, 24 Aug 2001 16:18:34 +0100 (BST)
Cc: davej@suse.de (Dave Jones),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <3B866C04.9090903@fugmann.dhs.org> from "Anders Peter Fugmann" at Aug 24, 2001 05:00:20 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15aIjC-0005vy-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> How "bad" is it to have __initdata declared static?

static is fine as it just changes name scoping, const however can try and
put data in other places such as code segments. That breaks stuff when
compiling with certain gcc versions
