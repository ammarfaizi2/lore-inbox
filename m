Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932879AbWF2LVm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932879AbWF2LVm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 07:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932888AbWF2LVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 07:21:42 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:56712 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932879AbWF2LVm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 07:21:42 -0400
Subject: Re: [PATCH] (Longhaul 1/5) PCI: Protect bus master DMA from
	Longhaul by rw semaphores
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: =?UTF-8?Q?Rafa=C5=82?= Bilski <rafalbilski@interia.pl>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <44A2C9A7.6060703@interia.pl>
References: <44A2C9A7.6060703@interia.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Date: Thu, 29 Jun 2006 12:37:57 +0100
Message-Id: <1151581077.23785.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-06-28 am 20:25 +0200, ysgrifennodd Rafał Bilski:
> AUTOHALT, this means interrupts must be disabled except for the time tick, 
> which should be reset to >=1ms. Care must be taken to avoid other system events 
> that could interfere with this operation. A few examples are snooping, NMI, 
> INIT, SMI and FLUSH."

"snooping". So we do need the cache sorting out.

