Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263298AbREWWfF>; Wed, 23 May 2001 18:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263300AbREWWez>; Wed, 23 May 2001 18:34:55 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:42757 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S263298AbREWWef>; Wed, 23 May 2001 18:34:35 -0400
Date: Wed, 23 May 2001 19:34:30 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: "G. Hugh Song" <ghsong@kjist.ac.kr>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Swap strangeness using 2.4.5pre2aa1
In-Reply-To: <3B0BFE90.CE148B7@kjist.ac.kr>
Message-ID: <Pine.LNX.4.33.0105231931580.311-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 May 2001, G. Hugh Song wrote:

> My Alpha/LInux UP2000 SMP with 1GB memory is running kernel

> The following is the output from "free"
> =========================================================================
>              total       used       free     shared    buffers     cached
> Mem:       1023128    1015640       7488          0        544     948976
> -/+ buffers/cache:      66120     957008
> Swap:      1021936    1021936          0
> ==========================================================================

> I understand that free swap space may become close to 0 and stay
> there for a while once it ever reached down close to zero.
> However, it should back up some nonzero number if the situation
> is cleared.

Something is wrong with the 2.4 VM.  As of yet, it cannot reclaim
swap space once it is full. This is pretty much the next thing on
my TODO list, right after the worst highmem lockups and balancing
issues have been fixed.

Watch http://www.surriel.com/patches/ closely, swap reclaiming is
next on my TODO list ;)

regards,

Rik
--
Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml

Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

