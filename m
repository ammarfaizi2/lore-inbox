Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262602AbVGMKYg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262602AbVGMKYg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 06:24:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262612AbVGMKYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 06:24:35 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:53699 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262562AbVGMKYR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 06:24:17 -0400
Date: Wed, 13 Jul 2005 12:24:07 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Konstantin Kudin <konstantin_kudin@yahoo.com>
cc: Horst von Brand <vonbrand@inf.utfsm.cl>, lkml@dervishd.net,
       linux-kernel@vger.kernel.org
Subject: Re: fdisk: What do plus signs after "Blocks" mean? 
In-Reply-To: <20050712204822.84567.qmail@web52001.mail.yahoo.com>
Message-ID: <Pine.LNX.4.61.0507131222300.14635@yvahk01.tjqt.qr>
References: <20050712204822.84567.qmail@web52001.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Guys, thanks a lot for the explanations!
>
> Actually, it seems like one can backup information on ALL partitions
>by using the command "sfdisk -dx /dev/hdX". Supposedly, it reads not
>only primary but also extended partitions. "sfdisk -x /dev/hdX" should
>be then able to write whatever is known back to the disk.

MBR size is 448 bytes, the rest is "the partition table", with space for four 
entries. If one wants more, then s/he creates a [primary] partition, tagging 
it "extended", and the "extended partiton table" is within that primary 
partition. So yes, by dd'ing /dev/hdX, you get everything. Including "lost 
sectors" if you dd it back to a bigger HD.
