Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266220AbRGYA3k>; Tue, 24 Jul 2001 20:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266224AbRGYA33>; Tue, 24 Jul 2001 20:29:29 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:18959 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266220AbRGYA3U>; Tue, 24 Jul 2001 20:29:20 -0400
Date: Tue, 24 Jul 2001 17:27:33 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: Patrick Dreker <patrick@dreker.de>, <phillips@bonn-fries.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Optimization for use-once pages
In-Reply-To: <Pine.LNX.4.33L.0107241924040.20326-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.33.0107241726130.29909-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


On Tue, 24 Jul 2001, Rik van Riel wrote:
>
> (using smaller chunks, or chunks which aren't a
> multiple of 4kB should break the current code)

Maybe Patrick is using stdio? In that case, the small chunks will be
coalesced in the library layer anyway, which might explain the lack of
breakage.

Of course, if it improved performance even when "broken", that would be
even better. I like those kind sof algorithms.

		Linus

