Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262242AbSJAU02>; Tue, 1 Oct 2002 16:26:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262263AbSJAU02>; Tue, 1 Oct 2002 16:26:28 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:21186 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S262242AbSJAU01>; Tue, 1 Oct 2002 16:26:27 -0400
Date: Tue, 1 Oct 2002 17:30:17 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: Andrew Morton <akpm@digeo.com>
Cc: Lawrence Walton <lawrence@the-penguin.otak.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Oops iee1394 video1394 rmap
In-Reply-To: <3D9A04B4.B1355CB6@digeo.com>
Message-ID: <Pine.LNX.4.44L.0210011729010.1909-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Oct 2002, Andrew Morton wrote:

> This would appear to be a page which was mapped by remap_page_range().
> It's not PageReserved, and it has no reverse mapping.
>
> I believe the right fix is to just delete the BUG check at rmap.c:280.

Yes.  I used to have this bugcheck in 2.4-rmap but removed it
ages ago. I have no idea why it was reintroduced in 2.5...

Rik
-- 
A: No.
Q: Should I include quotations after my reply?

http://www.surriel.com/		http://distro.conectiva.com/

