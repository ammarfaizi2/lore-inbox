Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130153AbRAEUjf>; Fri, 5 Jan 2001 15:39:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130027AbRAEUjZ>; Fri, 5 Jan 2001 15:39:25 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:63217 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129733AbRAEUjO>; Fri, 5 Jan 2001 15:39:14 -0500
Date: Fri, 5 Jan 2001 18:37:43 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Chris Mason <mason@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] changes to buffer.c (was Test12 ll_rw_block error)
In-Reply-To: <Pine.LNX.4.21.0101051642260.2882-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.21.0101051837200.1295-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Jan 2001, Marcelo Tosatti wrote:
> On Fri, 5 Jan 2001, Rik van Riel wrote:
> 
> > Also, you do not want the writer to block on writing out buffers
> > if bdflush could write them out asynchronously while the dirty
> > buffer producer can work on in the background.
> 
> flush_dirty_buffers() do not wait on the buffers written to get clean.

This sounds more like a bug we should fix then a reason
not to use flush_dirty_buffers()

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to loose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
