Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132303AbRAERfJ>; Fri, 5 Jan 2001 12:35:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132413AbRAERe7>; Fri, 5 Jan 2001 12:34:59 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:47110 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S132303AbRAERen>; Fri, 5 Jan 2001 12:34:43 -0500
Date: Fri, 5 Jan 2001 13:43:07 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Chris Mason <mason@suse.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] changes to buffer.c (was Test12 ll_rw_block error)
In-Reply-To: <662960000.978710044@tiny>
Message-ID: <Pine.LNX.4.21.0101051318190.2745-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 5 Jan 2001, Chris Mason wrote:

> 
> Here's the latest version of the patch, against 2.4.0.  The
> biggest open issues are what to do with bdflush, since
> page_launder could do everything bdflush does.  

I think we want to remove flush_dirty_buffers() from bdflush. 

While we are trying to be smart and do write clustering at the ->writepage
operation, flush_dirty_buffers() is "dumb" and will interfere with the
write clustering. 



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
