Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291589AbSBHOvv>; Fri, 8 Feb 2002 09:51:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291592AbSBHOvk>; Fri, 8 Feb 2002 09:51:40 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:47119 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S291589AbSBHOv2>; Fri, 8 Feb 2002 09:51:28 -0500
Subject: Re: [2.5.4-pre3] link error in drivers/video/video.o
To: eike@bilbo.math.uni-mannheim.de (Rolf Eike Beer)
Date: Fri, 8 Feb 2002 15:01:47 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200202081520.29475@bilbo.math.uni-mannheim.de> from "Rolf Eike Beer" at Feb 08, 2002 03:22:00 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16ZCX5-0003x1-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> drivers/video/video.o: In function `vesafb_init':
> drivers/video/video.o(.text.init+0x13f9): undefined reference to 
> `bus_to_virt_not_defined_use_pci_map'
> make: *** [vmlinux] Error 1

Someone made incorrect changes to the vesafb code. It was discussed but
not fixed before 2.5.3. vesafb should be using phys_to_virt
