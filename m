Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291616AbSBMMvN>; Wed, 13 Feb 2002 07:51:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291618AbSBMMvD>; Wed, 13 Feb 2002 07:51:03 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:57351 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S291616AbSBMMuy>; Wed, 13 Feb 2002 07:50:54 -0500
Subject: Re: PATCH 2.5.4 i810_audio, bttv, working at all.
To: dalecki@evision-ventures.com (Martin Dalecki)
Date: Wed, 13 Feb 2002 13:04:34 +0000 (GMT)
Cc: torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
In-Reply-To: <3C6A57CE.9010107@evision-ventures.com> from "Martin Dalecki" at Feb 13, 2002 01:10:54 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16az5O-0005CL-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  		{
> -			sg->busaddr=virt_to_bus(dmabuf->rawbuf+dmabuf->fragsize*i);
> +			sg->busaddr=virt_to_phys(dmabuf->rawbuf+dmabuf->fragsize*i);

No don't do this. The code needs changing to use the new PCI API

