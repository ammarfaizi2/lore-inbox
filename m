Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132743AbRDNFuN>; Sat, 14 Apr 2001 01:50:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132753AbRDNFuF>; Sat, 14 Apr 2001 01:50:05 -0400
Received: from zeus.kernel.org ([209.10.41.242]:32728 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S132764AbRDNFt6>;
	Sat, 14 Apr 2001 01:49:58 -0400
Date: Sat, 14 Apr 2001 00:53:07 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: PATCH(?): linux-2.4.4-pre2: fork should run child first
In-Reply-To: <20010412015516.A335@baldur.yggdrasil.com>
Message-ID: <Pine.LNX.4.21.0104140049360.12164-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Apr 2001, Adam J. Richter wrote:

> 	I have attached the patch below.  I have also adjusted the
> comment describing the code.  Please let me know if this hand waving
> explanation is sufficient.  I'm trying to be lazy on not do a
> measurement project to justify this relatively simple change.  

It could upset programs which use threads to handle
relatively IO poor things (like, waiting on disk IO in a
thread, like glibc does to fake async file IO).

Also, have you managed to find a real difference with this?

If it turns out to be beneficial to run the child first (you
can measure this), why not leave everything the same as it is
now but have do_fork() "switch threads" internally ?

(since everything is COW-ed, it wouldn't even need to do a real
thread switch, this should be fairly easy)

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

