Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbRAESWf>; Fri, 5 Jan 2001 13:22:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130690AbRAESWZ>; Fri, 5 Jan 2001 13:22:25 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:52486 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S130664AbRAESWL>; Fri, 5 Jan 2001 13:22:11 -0500
Date: Fri, 5 Jan 2001 14:30:41 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: linux-kernel@vger.kernel.org
cc: Rik van Riel <riel@conectiva.com.br>
Subject: swapin readahead pre-patch  
Message-ID: <Pine.LNX.4.21.0101051416080.2823-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, 

As I've told before, swapin readahead code is done at a physical basis,
and the correct thing is to swapin readahead only if the physical
on-swap pages are virtually contiguous wrt the one which suffered the
fault and is being swapped in. 

The following patch does this, and it also changes the readahead code to
readaround. I'm not sure if readaround is better than readahead for the
swapin case, and I'll have to test this more to make sure.

The code is not yet ready, but I'm posting the patch this way so people
can comment and test it.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
