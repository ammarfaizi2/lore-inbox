Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261375AbVBGI63@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbVBGI63 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 03:58:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261371AbVBGI62
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 03:58:28 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52675 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261370AbVBGI6Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 03:58:24 -0500
Message-ID: <42072DA0.8050302@pobox.com>
Date: Mon, 07 Feb 2005 03:58:08 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>,
       Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Tejun Heo <tj@home-tj.org>
Subject: Re: [rfc][patch] ide: fix unneeded LBA48 taskfile registers access
References: <Pine.GSO.4.58.0502062348200.2763@mion.elka.pw.edu.pl> <4206F2E5.7020501@gmail.com>
In-Reply-To: <4206F2E5.7020501@gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


FWIW, there are two limitations of libata in this area:

1) ISTR some PATA vendor-specific commands have a very specific set of 
input and output registers to use, and input/output sets of registers 
may differ from each other.

2) libata is lazy, and just reads registers in "groups":  the 
lbaH/M/L/nsect registers, the device register, etc.


