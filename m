Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932652AbWBYAnj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932652AbWBYAnj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 19:43:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932654AbWBYAnj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 19:43:39 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:57271 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932652AbWBYAni
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 19:43:38 -0500
Subject: Re: IT8212 ide controller problem
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Matheus Izvekov <mizvekov@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <305c16960602241326j35b71447g6540fa7f252b7e0e@mail.gmail.com>
References: <305c16960602241326j35b71447g6540fa7f252b7e0e@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 25 Feb 2006 00:47:53 +0000
Message-Id: <1140828474.11217.25.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2006-02-24 at 18:26 -0300, Matheus Izvekov wrote:
>  hdg:hdg: recal_intr: status=0x51 { DriveReady SeekComplete Error }
> hdg: recal_intr: error=0x04 { DriveStatusError }
> ide: failed opcode was: unknown
>  hdg1
> 
> This error doesnt happens if the same hd is connected to another ide
> controller on the same machine.


The core IDE code sends commands without checking if they are valid for
the hardware sometimes. This confuses the raid chip slightly but appears
harmless. I've no plan to fix it as I'm working on moving it to libata
anyway.

