Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129178AbQJ3GbM>; Mon, 30 Oct 2000 01:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129222AbQJ3GbC>; Mon, 30 Oct 2000 01:31:02 -0500
Received: from Cantor.suse.de ([194.112.123.193]:37388 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129178AbQJ3Gat>;
	Mon, 30 Oct 2000 01:30:49 -0500
Date: Mon, 30 Oct 2000 07:29:51 +0100
From: Andi Kleen <ak@suse.de>
To: dean gaudet <dean-list-linux-kernel@arctic.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <andrewm@uow.edu.au>,
        kumon@flab.fujitsu.co.jp, Andi Kleen <ak@suse.de>,
        Alexander Viro <viro@math.psu.edu>,
        "Jeff V. Merkey" <jmerkey@timpanogas.org>,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org,
        Olaf Kirch <okir@monad.swb.de>
Subject: Re: [PATCH] Re: Negative scalability by removal of lock_kernel()?(Was:
Message-ID: <20001030072950.A31668@gruyere.muc.suse.de>
In-Reply-To: <E13pYis-0005Q0-00@the-village.bc.nu> <Pine.LNX.4.21.0010291135570.11954-100000@twinlark.arctic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0010291135570.11954-100000@twinlark.arctic.org>; from dean-list-linux-kernel@arctic.org on Sun, Oct 29, 2000 at 11:45:49AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 29, 2000 at 11:45:49AM -0800, dean gaudet wrote:
> On Sat, 28 Oct 2000, Alan Cox wrote:
> 
> > > The big question is: why is Apache using file locking so
> > > much?  Is this normal behaviour for Apache?
> > 
> > Apache uses file locking to serialize accept on hosts where accept either has
> > bad thundering heard problems or was simply broken with multiple acceptors
> 
> if apache 1.3 is compiled with -DSINGLE_LISTEN_UNSERIALIZED_ACCEPT it'll
> avoid the fcntl() serialisation when there is only one listening port.  
> (it still uses it for multiple listeners... you can read all about my
> logic for that at <http://www.apache.org/docs/misc/perf-tuning.html>.)
> 
> is it appropriate for this to be defined for newer linux kernels?  i
> haven't kept track, sorry.  tell me what versions to conditionalize it on.

It should not be needed anymore for 2.4, because the accept() wakeup has been
fixed.


-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
