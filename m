Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130579AbRCEBUw>; Sun, 4 Mar 2001 20:20:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130580AbRCEBUc>; Sun, 4 Mar 2001 20:20:32 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:3578 "EHLO
	imladris.rielhome.conectiva") by vger.kernel.org with ESMTP
	id <S130579AbRCEBUV>; Sun, 4 Mar 2001 20:20:21 -0500
Date: Sun, 4 Mar 2001 21:29:05 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: "David S. Miller" <davem@redhat.com>
cc: Ulrich Kunitz <gefm21@uumail.de>, linux-kernel@vger.kernel.org,
        linux-mm@vger.kernel.org
Subject: Re: [PATCH] tiny MM performance and typo patches for 2.4.2
In-Reply-To: <15010.47547.612134.819466@pizda.ninka.net>
Message-ID: <Pine.LNX.4.21.0103042128240.5591-100000@imladris.rielhome.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Mar 2001, David S. Miller wrote:
> Ulrich Kunitz writes:
>  > patch-uk6	In 2.4.x _page_hashfn divides struct address_space pointer
>  > 		with a parameter derived from the size of struct
>  > 		inode. Deriving this parameter from the size of struct
>  > 		address_space makes more sense -- at least for me.
> 
> The address_space is %99 of the time (unless swapping, and in that
> case the address is constant :-)) inside of an inode struct so this
> change actually makes the hash worse.  I looked at this one time
> myself...

The other patches look fine to me. Alan, Linus, could
you please include Ulrich's other patches in the next
pre-kernel ?

thanks,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

