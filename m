Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265198AbSKSLXY>; Tue, 19 Nov 2002 06:23:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265211AbSKSLXY>; Tue, 19 Nov 2002 06:23:24 -0500
Received: from xsmtp.ethz.ch ([129.132.97.6]:29774 "EHLO xsmtp.ethz.ch")
	by vger.kernel.org with ESMTP id <S265201AbSKSLXX>;
	Tue, 19 Nov 2002 06:23:23 -0500
Message-ID: <3DDA20CD.8090502@debian.org>
Date: Tue, 19 Nov 2002 12:30:21 +0100
From: Giacomo Catenazzi <cate@debian.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.2b) Gecko/20021016
X-Accept-Language: en-us, en, it-ch, it, fr
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: [patch] ALSA compiler warnings fixes
References: <fa.h0vvikv.k5838k@ifi.uio.no>
In-Reply-To: <fa.h0vvikv.k5838k@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Nov 2002 11:30:22.0003 (UTC) FILETIME=[0BD81030:01C28FBF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +#define snd_power_unlock(card)		do { (void)(card); } while (0)



Why do we use in kernel:
	do { (void)(foobar); } while (0)
instead of the simpler and normally used in std files (e.g. assert.h):
	((void)(foobar),0)
?

The "do while(0)" is used for multi-statment macros, not the case for
void statment!

ciao
	giacomo

