Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264484AbRFOSuz>; Fri, 15 Jun 2001 14:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264485AbRFOSup>; Fri, 15 Jun 2001 14:50:45 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:15122 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S264484AbRFOSuk>; Fri, 15 Jun 2001 14:50:40 -0400
Date: Fri, 15 Jun 2001 15:50:33 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Ivan Schreter <is@zapwerk.com>
Cc: John Clemens <john@deater.net>, <linux-kernel@vger.kernel.org>
Subject: Re: Buffer management - interesting idea
In-Reply-To: <200106151705.TAA07359@borg4.zapnet.de>
Message-ID: <Pine.LNX.4.33.0106151550010.2262-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jun 2001, Ivan Schreter wrote:

> In 2Q, when a page is present in LRU queue, you move it to the front of
> LRU queue as usual. Otherwise, if it is in memory, it must be in A1 queue
> (the FIFO one), so you DON'T do anything. When the page is NOT in memory,
> you load it conditionally to Am LRU queue (if it is present in A1out
> queue) or to A1 queue (FIFO), if not.
>
> It gets interesting when you need to swap out a page from memory. When the
> size of A1 FIFO is greater than limit (e.g., 10% of buffer space), a page
> from A1 is swapped out (and put into A1out list), otherwise a page from Am
> LRU is swapped out (and NOT put into A1out, since it hasn't been accessed
> for long time).

This description has me horribly confused. Do you have
any pointers to state diagrams of this thing? ;)

regards,

Rik
--
Executive summary of a recent Microsoft press release:
   "we are concerned about the GNU General Public License (GPL)"


		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

