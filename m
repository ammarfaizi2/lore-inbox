Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129606AbRBKPrV>; Sun, 11 Feb 2001 10:47:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129607AbRBKPrC>; Sun, 11 Feb 2001 10:47:02 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:14585 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129606AbRBKPqu>; Sun, 11 Feb 2001 10:46:50 -0500
Date: Sun, 11 Feb 2001 12:44:00 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Mike Galbraith <mikeg@wen-online.de>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.1-ac7
In-Reply-To: <Pine.Linu.4.10.10102110954140.944-100000@mikeg.weiden.de>
Message-ID: <Pine.LNX.4.21.0102111243090.2378-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Feb 2001, Mike Galbraith wrote:
> On Sun, 11 Feb 2001, Mike Galbraith wrote:
> 
> > Something else I see while watching it run:  MUCH more swapout than
> > swapin.  Does that mean we're sending pages to swap only to find out
> > that we never need them again?
> 
> (numbers might be more descriptive)
> 
> user  :       0:07:21.70  54.3%  page in :   142613
> nice  :       0:00:00.00   0.0%  page out:   155454
> system:       0:03:40.63  27.1%  swap in :    56334
> idle  :       0:02:30.50  18.5%  swap out:   149872
> uptime:       0:13:32.83         context :   519726

Indeed, in this case we send a lot more pages to swap
than we read back in from swap, this means that the
data is still sitting in swap space and was never needed
again.

regards,

Rik
--
Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml

Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
