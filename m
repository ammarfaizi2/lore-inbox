Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319044AbSHMTVB>; Tue, 13 Aug 2002 15:21:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319048AbSHMTVB>; Tue, 13 Aug 2002 15:21:01 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:50450 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S319044AbSHMTVA>; Tue, 13 Aug 2002 15:21:00 -0400
Date: Tue, 13 Aug 2002 12:26:43 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jeff Dike <jdike@karaya.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] UML - part 2 of 3 
In-Reply-To: <200208132008.PAA03902@ccure.karaya.com>
Message-ID: <Pine.LNX.4.44.0208131225470.7411-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 13 Aug 2002, Jeff Dike wrote:
> 
> The root_dev_names array looks like it can be eliminated entirely, as long
> as the gendisk list is populated before checksetup.

Well, think of it as "gendisk is populated before root device needs to be 
mounted".

And the fact is, it clearly has to be _anyway_.

The name lookup shouldn't be done any earlier than the actual mount 
anyway.

		Linus

