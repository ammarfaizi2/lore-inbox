Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262116AbVEEOr5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262116AbVEEOr5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 10:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262118AbVEEOr5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 10:47:57 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:12436 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S262116AbVEEOrx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 10:47:53 -0400
Subject: Re: ata over ethernet question
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Maciej Soltysiak <solt2@dns.toxicfilms.tv>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1416215015.20050504193114@dns.toxicfilms.tv>
References: <1416215015.20050504193114@dns.toxicfilms.tv>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1115304380.19844.74.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 05 May 2005 15:46:22 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-05-04 at 18:31, Maciej Soltysiak wrote:
> Would it be possible to use tha AOE driver to
> attach one ATA drive in a host over ethernet to another
> host ? Or is it support for specific hardware devices only?

It talks ATA command blocks but if you write an ATA command block parser
you can write yourself a remote device stack and the protocol is very
simple. For block storage NBD is probably simpler and more efficient but
AoE might be interesting for accessing embedded microcontrollers and the
like because you don't need a TCP/IP stack.

Alan

