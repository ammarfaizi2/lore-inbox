Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261350AbULXAne@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261350AbULXAne (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 19:43:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261352AbULXAne
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 19:43:34 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:28564 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261350AbULXAnd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 19:43:33 -0500
Subject: Re: DMA problems with 3+ Promise IDE controllers
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jaco van der Schyff <jvds@netgroup.co.za>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <41CB1BE3.465BD490@netgroup.co.za>
References: <41CB1BE3.465BD490@netgroup.co.za>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1103845162.15233.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 23 Dec 2004 23:39:24 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-12-23 at 19:26, Jaco van der Schyff wrote:
> Any idea how I could get all three cards to work in UDMA100 mode?

You either need multiple independant PCI busses or to write an
arbitrator for the IDE DMA layer to ensure that no more than two of the
three are doing DMA transfers at a time and the other waits. 

Alan

