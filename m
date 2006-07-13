Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964782AbWGML6o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964782AbWGML6o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 07:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964781AbWGML6o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 07:58:44 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:22432 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964782AbWGML6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 07:58:43 -0400
Subject: Re: Bugs in usb-skeleton.c??? :)
From: Arjan van de Ven <arjan@infradead.org>
To: Sergej Pupykin <ps@lx-ltd.ru>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <m3odvtvj8w.fsf@lx-ltd.ru>
References: <m3odvtvj8w.fsf@lx-ltd.ru>
Content-Type: text/plain
Date: Thu, 13 Jul 2006 13:58:37 +0200
Message-Id: <1152791917.3024.39.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-07-13 at 15:26 +0400, Sergej Pupykin wrote:
> Hello, All!
> 
> As I understand, USB subsystem uses urb->transfer_buffer directly with
> DMA. I see that usb-skeleton.c and (at least) bluez's hci_usb allocates it
> without GFP_DMA flag. (skeleton with GFP_KERNEL, bluez with GFP_ATOMIC)

Hi,

I think GFP_DMA means something different than that you think it means.
GFP_DMA is a bad old hack that means "this is for ISA bus cards to DMA
to/from". Since there are no ISA bus USB controllers... the USB code
doesn't need to use GFP_DMA.

Greetings,
   Arjan van de Ven

