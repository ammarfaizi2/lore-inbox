Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261712AbUCIN6P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 08:58:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261939AbUCIN6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 08:58:15 -0500
Received: from gort.metaparadigm.com ([203.117.131.12]:40380 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id S261712AbUCIN6O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 08:58:14 -0500
Message-ID: <404DCD71.706@metaparadigm.com>
Date: Tue, 09 Mar 2004 21:58:09 +0800
From: Michael Clark <michael@metaparadigm.com>
Organization: Metaparadigm Pte Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Jinu M." <jinum@esntechnologies.co.in>
Cc: Stefan Smietanowski <stesmi@stesmi.com>, linux-kernel@vger.kernel.org
Subject: Re: disable partitioning!
References: <1118873EE1755348B4812EA29C55A97217632E@esnmail.esntechnologies.co.in>
In-Reply-To: <1118873EE1755348B4812EA29C55A97217632E@esnmail.esntechnologies.co.in>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/09/04 20:13, Jinu M. wrote:
> 
> Hello Stefan.
> 
> 
>>We are writing a block device driver for 2.4.x kernel.
>>I want to know how to indicate to the filesystem that our block driver does not support partitions.
>>I mean fdisk should not be allowed on disks supported by our block driver.
> 
> 
> You can run fdisk on a file if you want to, it doesn't care what type of
> block device it is. What you're really asking for is a way to make the
> kernel not read the partition table if it exists on the device and
> that's something else.
> 
> So then how do I stop kernel from reading the partition table?

I believe you can do this by passing 1 as the number of minors
in your call to alloc_disk(int num_minors).

~mc
