Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317404AbSHYQvq>; Sun, 25 Aug 2002 12:51:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317415AbSHYQvq>; Sun, 25 Aug 2002 12:51:46 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:48772 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S317404AbSHYQvq>;
	Sun, 25 Aug 2002 12:51:46 -0400
Message-ID: <3D690C1F.1090604@colorfullife.com>
Date: Sun, 25 Aug 2002 18:55:59 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/4.0 (compatible; MSIE 5.5; Windows NT 4.0)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
CC: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [patch 2.5.31] transparent PCI-to-PCI bridges
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ivan wrote:
> +	/*
> +	 * The PCI-to-PCI bridge spec requires that subtractive decoding
> +	 * (i.e. transparent) bridge must have programming interface code
> +	 * of 0x01.
> +	 */ 
> +	if (dev->class & 1) {
> +		printk("Transparent bridge - %s\n", dev->name);

Why not
	if ((dev->class & 0xff) == 0x01)

Is the lowest bit an indicator of subtractive decoding, or is 
Progif==0x01 the indicator of subtractive decoding?
The code and the comment should match.

--
	Manfred

