Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263359AbRFKDEM>; Sun, 10 Jun 2001 23:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263370AbRFKDEC>; Sun, 10 Jun 2001 23:04:02 -0400
Received: from [203.36.158.121] ([203.36.158.121]:29956 "EHLO
	piro.kabuki.sfarc.net") by vger.kernel.org with ESMTP
	id <S263359AbRFKDDw>; Sun, 10 Jun 2001 23:03:52 -0400
Date: Mon, 11 Jun 2001 13:03:14 +1000
From: Daniel Stone <daniel@kabuki.sfarc.net>
To: Rik van Riel <riel@conectiva.com.br>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.6-pre2 page_launder() improvements
Message-ID: <20010611130314.B964@kabuki.openfridge.net>
Mail-Followup-To: Rik van Riel <riel@conectiva.com.br>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0106100128100.4239-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0106100128100.4239-100000@duckman.distro.conectiva>
User-Agent: Mutt/1.3.18i
Organisation: Sadly lacking
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 10, 2001 at 01:40:44AM -0300, Rik van Riel wrote:
> [Request For Testers ... patch below]
> 
> Hi,
> 
> during my holidays I've written the following patch (forward-ported
> to 2.4.6-pre2 and improved a tad today), which implements these
> improvements to page_launder():
> 
> YMMV, please test it. If it works great for everybody I'd like
> to get this improvement merged into the next -pre kernel.

I forgot about vmstat, but this is -ac12, anecdotal evidence - my system
(weak) performs far better under heavy load (mpg123 nice'd to -20 + apt/dpkg
+ gcc), than with vanilla -ac12. To get it to compile on -ac, just hand-hack
in the patch, and s/CAN_GET_IO/can_get_io_locks/ in vmscan.c.

:) d

-- 
Daniel Stone		<daniel@kabuki.openfridge.net> <daniel@kabuki.sfarc.net>
