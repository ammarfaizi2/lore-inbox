Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030500AbWF1KLp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030500AbWF1KLp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 06:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932567AbWF1KLp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 06:11:45 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:4228 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932538AbWF1KLo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 06:11:44 -0400
Subject: Re: [PATCH] watchdog: add pretimeout ioctl
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Corey Minyard <minyard@acm.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       OpenIPMI Developers <openipmi-developer@lists.sourceforge.net>,
       Wim Van Sebroeck <wim@iguana.be>
In-Reply-To: <44A1D5E5.3020903@acm.org>
References: <20060627182225.GD10805@localdomain>
	 <1151434785.32186.56.camel@localhost.localdomain>
	 <44A1D5E5.3020903@acm.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 28 Jun 2006 11:27:18 +0100
Message-Id: <1151490438.15166.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-06-27 am 20:05 -0500, ysgrifennodd Corey Minyard:
> since even if the machine is hard-locked the NMI will come through.

Don't bet on that. There are a considerable number of crash stall cases
where NMI will not be delivered, plus you can disable NMI if you are
really sneaky and want to.

The usual case NMI fails is crashed video cards. The PCI transaction
stalls forever on many boards and the CPU therefore never finishes the
instruction and never services the NMI


Alan
