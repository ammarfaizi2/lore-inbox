Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318173AbSIOSvt>; Sun, 15 Sep 2002 14:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318176AbSIOSvt>; Sun, 15 Sep 2002 14:51:49 -0400
Received: from 2-028.ctame701-1.telepar.net.br ([200.193.160.28]:25029 "EHLO
	2-028.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S318173AbSIOSvt>; Sun, 15 Sep 2002 14:51:49 -0400
Date: Sun, 15 Sep 2002 15:56:14 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Andrew Morton <akpm@digeo.com>
cc: "M. Edward Borasky" <znmeb@aracnet.com>, Axel Siebenwirth <axel@hh59.org>,
       Con Kolivas <conman@kolivas.net>, lkml <linux-kernel@vger.kernel.org>,
       <linux-mm@kvack.org>, <lse-tech@lists.sourceforge.net>
Subject: Re: 2.5.34-mm4
In-Reply-To: <3D84D799.557653C7@digeo.com>
Message-ID: <Pine.LNX.4.44L.0209151554520.1857-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Sep 2002, Andrew Morton wrote:

> - In -ac, there are noticeable stalls during heavy writeout.  This
>   may be an ext3 thing, but I can't think of any IO scheduling
>   differences in -ac ext3.  I'd be guessing that it is due to
>   bdflush/kupdate lumpiness.

This is also due to the fact that -ac has an older -rmap
VM. As in current 2.5, rmap can write out all inactive
pages ... and it did in some worst case situations.

This is fixed in rmap14.

(I hope Alan is done playing with IDE soon so I can push
him a VM update)

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

Spamtraps of the month:  september@surriel.com trac@trac.org

