Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317211AbSHBVeD>; Fri, 2 Aug 2002 17:34:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317217AbSHBVeD>; Fri, 2 Aug 2002 17:34:03 -0400
Received: from pD952AC04.dip.t-dialin.net ([217.82.172.4]:23233 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S317211AbSHBVeC>; Fri, 2 Aug 2002 17:34:02 -0400
Date: Fri, 2 Aug 2002 15:36:44 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Mike Touloumtzis <miket@bluemug.com>
cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
       Alexander Viro <viro@math.psu.edu>,
       Thunder from the hill <thunder@ngforever.de>,
       Peter Chubb <peter@chubb.wattle.id.au>, Pavel Machek <pavel@ucw.cz>,
       <Matt_Domsch@Dell.com>, <Andries.Brouwer@cwi.nl>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] 2.5.28 and partitions
In-Reply-To: <20020802212149.GC4528@bluemug.com>
Message-ID: <Pine.LNX.4.44.0208021532020.5119-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 2 Aug 2002, Mike Touloumtzis wrote:
> fprintf(f, "%u %u %u%c", foo, bar, baz, '\0');

Yes, that's crap... However, what about the following partition table 
format:

<size>\0<part1>\n<part2>\n<part...>\n<partn>\0

Size represents the complete size of the partition table. partx defines 
the partitions that we have, part1 starts at
		(size % BLOCK_SIZE			?
		 drive_start+(size/BLOCK_SIZE)		: 
		 drive_start+(SIZE/BLOCK_SIZE)+1)

String encoding is possible, not a requirement...

			Thunder
-- 
.-../../-./..-/-..- .-./..-/.-.././.../.-.-.-

