Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278081AbRKMSek>; Tue, 13 Nov 2001 13:34:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278103AbRKMSeb>; Tue, 13 Nov 2001 13:34:31 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:17682 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S278085AbRKMSeU>; Tue, 13 Nov 2001 13:34:20 -0500
Date: Tue, 13 Nov 2001 16:33:53 -0200 (BRST)
From: Rik van Riel <riel@marcelothewonderpenguin.com>
X-X-Sender: <riel@duckman.distro.conectiva>
To: <root@gollum.uci.agh.edu.pl>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Compilation crashed
In-Reply-To: <200111131930.fADJU5o07216@gollum.uci.agh.edu.pl>
Message-ID: <Pine.LNX.4.33L.0111131632560.20809-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Nov 2001 root@gollum.uci.agh.edu.pl wrote:

> 1.Compilation crash

> drivers/block/block.o: In function `lo_send':
> drivers/block/block.o(.text+0x8baf): undefined reference to `deactivate_page'
> drivers/block/block.o(.text+0x8bf9): undefined reference to `deactivate_page'
> make: *** [vmlinux] Error 1

The function deactivate_page was removed from kernel 2.4.14,
you can edit drivers/block/loop.c and remove the two lines
which call deactivate_page(page) ...

After that, things work.

regards,

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/

http://www.surriel.com/		http://distro.conectiva.com/

