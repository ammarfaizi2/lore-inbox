Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261687AbTKONNK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Nov 2003 08:13:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261692AbTKONNK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Nov 2003 08:13:10 -0500
Received: from hades.mk.cvut.cz ([147.32.96.3]:8326 "EHLO hades.mk.cvut.cz")
	by vger.kernel.org with ESMTP id S261687AbTKONNI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Nov 2003 08:13:08 -0500
Message-ID: <3FB62662.8030609@kmlinux.fjfi.cvut.cz>
Date: Sat, 15 Nov 2003 14:13:06 +0100
From: Jindrich Makovicka <makovick@kmlinux.fjfi.cvut.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6a) Gecko/20031029
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: loopback device + crypto = crash on 2.6.0-test7 ?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can confirm, having similar problem. I am using Debian Sid & 
2.6.0-test9, with 4Gig highmem support (1.5G physical RAM). When reading 
from cryptoloop (dd if=/dev/loop0 of=testoutput), it seems to produce 
only noise. Each run of dd produces completely different heap of 
garbage. When I disable highmem, getting rid of about 512 Megs, 
cryptoloop seems to work as expected - I can do losetup & mke2fs & mount 
& read/write files & unmount & losetup -d & again.. ad nauseam.

Regards,
-- 
Jindrich Makovicka
