Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313424AbSDGTBI>; Sun, 7 Apr 2002 15:01:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313425AbSDGTBH>; Sun, 7 Apr 2002 15:01:07 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:44807 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S313424AbSDGTBG>; Sun, 7 Apr 2002 15:01:06 -0400
Subject: Re: Two fixes for 2.4.19-pre5-ac3
To: movement@marcelothewonderpenguin.com (John Levon)
Date: Sun, 7 Apr 2002 20:18:16 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        shirsch@adelphia.net (Steven N. Hirsch), linux-kernel@vger.kernel.org
In-Reply-To: <20020407173343.GA18940@compsoc.man.ac.uk> from "John Levon" at Apr 07, 2002 06:33:43 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16uIB6-0006TQ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm a bit disappointed this has just gone in without any real discussion
> on the usefulness of this for certain circumstances :(

How about "there are no correct users". Its basically impossible to patch
the syscall table safely anyway. As Arjan pointed out there are races 
against module unload that on SMP are basically incurable. Doing the
right hooks makes the AFS code portable which is a big win.
