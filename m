Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132848AbRDQTkM>; Tue, 17 Apr 2001 15:40:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132845AbRDQTiy>; Tue, 17 Apr 2001 15:38:54 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:59143 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S132844AbRDQTiA>; Tue, 17 Apr 2001 15:38:00 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Subtle MM bug
Date: 17 Apr 2001 12:37:22 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9bi61i$5ql$1@cesium.transmeta.com>
In-Reply-To: <87wvburowk.fsf@atlas.iskon.hr> <Pine.LNX.4.31.0101181230020.31432-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.31.0101181230020.31432-100000@localhost.localdomain>
By author:    Rik van Riel <riel@conectiva.com.br>
In newsgroup: linux.dev.kernel
> 
> Suppose you have 8 high-priority tasks waiting on kswapd
> and one lower-priority (but still higher than kswapd)
> process running and preventing kswapd from doing its work.
> Oh .. and also preventing the higher-priority tasks from
> being woken up and continuing...
> 

Classic priority inversion.  In this particular case it seems like it
should be unusually simple to apply priority inheritance, though (the
general case is complicated by the fact that the dependency matrix
usually isn't readily available.)

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
