Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319312AbSIKRTm>; Wed, 11 Sep 2002 13:19:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319311AbSIKRTm>; Wed, 11 Sep 2002 13:19:42 -0400
Received: from mailout08.sul.t-online.com ([194.25.134.20]:24711 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S319312AbSIKRS5> convert rfc822-to-8bit; Wed, 11 Sep 2002 13:18:57 -0400
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <oliver@neukum.name>
To: Rik van Riel <riel@conectiva.com.br>,
       Xuan Baldauf <xuan--lkml@baldauf.org>
Subject: Re: Heuristic readahead for filesystems
Date: Wed, 11 Sep 2002 19:20:58 +0200
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org, Reiserfs List <reiserfs-list@namesys.com>
References: <Pine.LNX.4.44L.0209111340060.1857-100000@imladris.surriel.com>
In-Reply-To: <Pine.LNX.4.44L.0209111340060.1857-100000@imladris.surriel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209111920.58952.oliver@neukum.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 11. September 2002 18:42 schrieb Rik van Riel:

> Your observation is right, but I'm not sure how much it will
> matter if we start reading the file at stat() time or at
> read() time.
>
> This is because one disk seek takes about 10 million CPU
> cycles on modern systems and we'll have completed the stat(),
> open() and started the read() before the disk arm has started
> moving ;)

Do we gain by sorting the disk accesses ?
How about savings due to better cooperation with the IO
scheduler?

	Regards
		Oliver

