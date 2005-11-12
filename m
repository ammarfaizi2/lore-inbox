Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932429AbVKLRch@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932429AbVKLRch (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 12:32:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932428AbVKLRch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 12:32:37 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:9925 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932422AbVKLRcg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 12:32:36 -0500
Subject: Re: 2.6.15-rc1: IDE: fix potential data corruption with SL82C105
	interfaces
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20051112165548.GB28987@flint.arm.linux.org.uk>
References: <20051112165548.GB28987@flint.arm.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 12 Nov 2005 18:03:34 +0000
Message-Id: <1131818615.18258.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2005-11-12 at 16:55 +0000, Russell King wrote:
> We must _never_ _ever_ on pain of death enable IDE DMA on SL82C105
> chipsets where the southbridge revision is <= 5, otherwise data
> corruption will occur.


If you are fixing this driver also set ->serialize = 1; before someone
with dual channel device gets burned.

