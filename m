Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129228AbQLSEFL>; Mon, 18 Dec 2000 23:05:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129267AbQLSEEw>; Mon, 18 Dec 2000 23:04:52 -0500
Received: from monza.monza.org ([209.102.105.34]:38410 "EHLO monza.monza.org")
	by vger.kernel.org with ESMTP id <S129228AbQLSEEl>;
	Mon, 18 Dec 2000 23:04:41 -0500
Date: Mon, 18 Dec 2000 19:34:05 -0800
From: Tim Wright <timw@splhi.com>
To: Daniel Phillips <phillips@innominate.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Semaphores used for daemon wakeup
Message-ID: <20001218193405.A24041@scutter.internal.splhi.com>
Reply-To: timw@splhi.com
Mail-Followup-To: Daniel Phillips <phillips@innominate.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <0012171922570J.00623@gimli>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <0012171922570J.00623@gimli>; from phillips@innominate.de on Sun, Dec 17, 2000 at 01:06:10PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 17, 2000 at 01:06:10PM +0100, Daniel Phillips wrote:
> This patch illustrates an alternative approach to waking and waiting on
> daemons using semaphores instead of direct operations on wait queues.
> The idea of using semaphores to regulate the cycling of a daemon was
> suggested to me by Arjan Vos.  The basic idea is simple: on each cycle
> a daemon down's a semaphore, and is reactivated when some other task
> up's the semaphore.
[...]
> 
> OK, there it is.  Is this better, worse, or lateral?

Well, I have to confess I'm rather fond of this method, but that could have
something to do with it being how we did it in DYNIX/ptx (Sequent).
It certainly works, and I find it very clear, but of course I'm biased :-)

Tim

--
Tim Wright - timw@splhi.com or timw@aracnet.com or twright@us.ibm.com
"Nobody ever said I was charming, they said "Rimmer, you're a git!"" RD VI
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
