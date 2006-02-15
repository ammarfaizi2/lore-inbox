Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422957AbWBOE4D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422957AbWBOE4D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 23:56:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422958AbWBOE4D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 23:56:03 -0500
Received: from smtp.osdl.org ([65.172.181.4]:17130 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422957AbWBOE4B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 23:56:01 -0500
Date: Tue, 14 Feb 2006 20:54:58 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Nikolay N. Ivanov" <nn@nndl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.15.x - very slow disk-writing
Message-Id: <20060214205458.10328f36.akpm@osdl.org>
In-Reply-To: <43F2D3A3.9030707@nndl.org>
References: <43F0F67A.8080001@nndl.org>
	<20060213200517.20f7a291.akpm@osdl.org>
	<43F2BEE5.5060002@nndl.org>
	<20060214193121.752767ee.akpm@osdl.org>
	<43F2D3A3.9030707@nndl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Nikolay N. Ivanov" <nn@nndl.org> wrote:
>
> /dev/hda:
>    multcount    = 16 (on)
>    IO_support   =  0 (default 16-bit)
>    unmaskirq    =  0 (off)
>    using_dma    =  0 (off)
>    keepsettings =  0 (off)
>    readonly     =  0 (off)
>    readahead    = 256 (on)
>    geometry     = 16383/255/63, sectors = 40060403712, start = 0

The disk isn't using DMA.

Check your IDE config settings, make sure that the right chipset support is
turned on, that "Generic PCI bus-master DMA support" is enabled, check
"Force enable legacy 2.0.X HOSTS to use DMA", "Use PCI DMA by default when
available", "Enable DMA only for disks", etc.

If none of that gets it into DMA mode then we might have broken the IDE
driver.

