Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261624AbSK3SPt>; Sat, 30 Nov 2002 13:15:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267281AbSK3SPt>; Sat, 30 Nov 2002 13:15:49 -0500
Received: from [200.193.163.106] ([200.193.163.106]:59038 "EHLO
	5-106.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S261624AbSK3SPs>; Sat, 30 Nov 2002 13:15:48 -0500
Date: Sat, 30 Nov 2002 16:22:12 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Steffen Moser <lists@steffen-moser.de>
cc: Javier Marcet <jmarcet@pobox.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Exaggerated swap usage
In-Reply-To: <20021130140518.GB1735@steffen-moser.de>
Message-ID: <Pine.LNX.4.44L.0211301621200.15981-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Nov 2002, Steffen Moser wrote:

> I've experienced a similar problem with "linux-2.4.20-rc2-ac3",
> "linux-2.4.20-rc4-ac1" and "linux-2.4.20-ac1". At first I also
> thought it's a swap problem, but this seems to be a wrong con-
> clusion, too.

Known problem, rmap14 doesn't do pageout IO soon enough. This
is good if the inactive pages are clean (cache) but stalls the
system if the data needs to be written to disk.

This should be fixed in rmap15.

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://guru.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>

