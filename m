Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129053AbQJ3JO5>; Mon, 30 Oct 2000 04:14:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129137AbQJ3JOr>; Mon, 30 Oct 2000 04:14:47 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:12550 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129053AbQJ3JOe>; Mon, 30 Oct 2000 04:14:34 -0500
Date: Mon, 30 Oct 2000 02:11:11 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks!
Message-ID: <20001030021111.A19975@vger.timpanogas.org>
In-Reply-To: <20001030015546.B19869@vger.timpanogas.org> <Pine.LNX.4.21.0010301109280.3186-100000@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.21.0010301109280.3186-100000@elte.hu>; from mingo@elte.hu on Mon, Oct 30, 2000 at 11:13:58AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2000 at 11:13:58AM +0100, Ingo Molnar wrote:
> 
> On Mon, 30 Oct 2000, Jeff V. Merkey wrote:
> 
> > No argument here, but the overhead of reloading CR3 period will kill
> > performance. [...]
> 
> 2.4 does not reload CR3, unless you are using multiple user-space
> processes.
> 
> > 2.4 does not beat NetWare, BTW, it gets a little further, but still
> > hits the wall, [...]
> 
> as i told you in the previous mail, the main overhead is not CR3, it's the
> copying & dirtying of all data, and the subsequent DMA-initiated dirty
> cacheline writeback. I can serve 100 MB/sec web content with 2.4 & TUX
> just fine - it relies on a zero-copying infrastructure.
> 
> 	Ingo


Great Ingo, you've got the web server covered.  What about file and print.  
I think this is great, but most web servers are connected to a T1 or T3 
line, and all the fancy optimization means absolutely squat since about 
99.999999% of the planet has a max baandwidth of a T1, ADSL, or T3 Line,
this is a far cry from Gigabit ethernet, or even 100Mbit ethernet.  

How many users can you put on the web server?  Web servers are also 
read only data, the easiest of all LAN cases to deal with.  It's 
incoming writes that present all the tough problems, as Andi Klein
wisely observed.  Not to knock Tux, I think it's great, but it does
not solve the file and print scaling problem, no does it?

Jeff
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
