Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261245AbULHQ0O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbULHQ0O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 11:26:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261252AbULHQ0O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 11:26:14 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:12207 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261245AbULHQ0J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 11:26:09 -0500
Message-ID: <41B72B1E.5050307@pobox.com>
Date: Wed, 08 Dec 2004 11:26:06 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: DMA problems with ICH5 in ATA mode
References: <62697744-490D-11D9-90F0-000D932A43BC@karlsbakk.net>
In-Reply-To: <62697744-490D-11D9-90F0-000D932A43BC@karlsbakk.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roy Sigurd Karlsbakk wrote:
> hi
> 
> I have a disk connected to one of the below controllers in ATA mode, but 
> I can't enable DMA on it. Intel ATA support is in kernel, but when 
> hdparm -d1 /dev/hdc I get the following (extracted from strace)
> 
> write(4, " HDIO_SET_DMA failed: Operation "..., 46 HDIO_SET_DMA failed: 
> Operation not permitted

You either need to (a) disable legacy (combined) mode, (b) use piix 
rather than generic IDE driver, or (c) enable libata for your SATA.

	Jeff



