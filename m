Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135743AbRDXXH4>; Tue, 24 Apr 2001 19:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135634AbRDXXHq>; Tue, 24 Apr 2001 19:07:46 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:33039 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135621AbRDXXHd>; Tue, 24 Apr 2001 19:07:33 -0400
Subject: Re: Linux 2.4.3ac13
To: ksi@cyberbills.com (Sergey Kubushin)
Date: Wed, 25 Apr 2001 00:09:03 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.31ksi3.0104241559530.1039-100000@nomad.cyberbills.com> from "Sergey Kubushin" at Apr 24, 2001 04:00:23 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14sBvd-0003Au-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> === Cut ===
> [root@nomad /root]# depmod -ae
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.3ac13/kernel/drivers/net/aironet4500_card.o
> depmod:         __bad_udelay
> === Cut ===

Yeah I need to change the __bad_udelay trick. The inline in inline case that
triggers a bad_udelay link wrongly is annoying but apparently not something
the gcc folks guarantee wont happen.
