Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268841AbRHFQMs>; Mon, 6 Aug 2001 12:12:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268843AbRHFQMi>; Mon, 6 Aug 2001 12:12:38 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:36367 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S268841AbRHFQMa>; Mon, 6 Aug 2001 12:12:30 -0400
Date: Mon, 6 Aug 2001 13:12:28 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: "David S. Miller" <davem@redhat.com>
Cc: Andrea Arcangeli <andrea@suse.de>,
        David Luyer <david_luyer@pacific.net.au>,
        <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: /proc/<n>/maps growing...
In-Reply-To: <15214.24938.681121.837470@pizda.ninka.net>
Message-ID: <Pine.LNX.4.33L.0108061311120.1439-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Aug 2001, David S. Miller wrote:
> Andrea Arcangeli writes:
>  > Can somebody see a problem with this design?
>
> As someone who was involved when the merge_segments stuff got tossed
> by Linus, the reason was that the locking is utterly atrocious.

Mmmm, don't we ONLY need to hold both the mm->mmap_sem for
write access and the mm->page_table_lock ?

... which we are already holding at that point.

regards,

Rik
--
Executive summary of a recent Microsoft press release:
   "we are concerned about the GNU General Public License (GPL)"


		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

