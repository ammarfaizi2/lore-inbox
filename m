Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129529AbRCWX51>; Fri, 23 Mar 2001 18:57:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131362AbRCWX5S>; Fri, 23 Mar 2001 18:57:18 -0500
Received: from monza.monza.org ([209.102.105.34]:13835 "EHLO monza.monza.org")
	by vger.kernel.org with ESMTP id <S129529AbRCWX5F>;
	Fri, 23 Mar 2001 18:57:05 -0500
Date: Fri, 23 Mar 2001 15:56:00 -0800
From: Tim Wright <timw@splhi.com>
To: Tom Diehl <tdiehl@pil.net>
Cc: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prevent OOM from killing init
Message-ID: <20010323155600.A2534@kochanski.internal.splhi.com>
Reply-To: timw@splhi.com
Mail-Followup-To: Tom Diehl <tdiehl@pil.net>,
	Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0103231154440.29682-100000@imladris.rielhome.conectiva> <Pine.LNX.4.30.0103231504520.19312-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0103231504520.19312-100000@localhost.localdomain>; from tdiehl@pil.net on Fri, Mar 23, 2001 at 03:20:41PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Netscape 4 has some very nasty habits like suddenly consuming ~80MB of memory.
Disabling java support seems to eradicate most occurences of this particularly
obnoxious behaviour. Under these circumstances, the OOM killer is doing exactly
the right thing i.e. killing a runaway app.

Tim

On Fri, Mar 23, 2001 at 03:20:41PM -0500, Tom Diehl wrote:
> On Fri, 23 Mar 2001, Rik van Riel wrote:
> 
> > Well, in that case you'll have to live with the current OOM
> > killer.  Martin wrote down a pretty detailed description of
> > what's wrong with my algorithm, if it really bothers him he
> > should be able to come up with something better.
> >
> > Personally, I think there is more important VM code to look
> > after, since OOM is a pretty rare occurrance anyway.
> 
> Well actually it is not that rare at least for me. Every 3 or 4 days I run
> into it (It happened again this morning). The machine has 128 Megs of ram
> and 256 Megs of swap. It is my desktop machine and I keep 3 or 4 netscape
> windows running all of the time. Well I try to at least. Every 3 or 4 days
> the OOM Killer kills netscape, it happened this morning. If I could fix it
> I would but alas I do not have the knowledge. The best I can do is test. :(
> 
> This is NOT a complaint I just bring this up as another data point.
> It used to lock the machine so things are getting better. fwiw, I am
> currently running 2.4.2-ac18. The old ac kernels (do not remember exactly
> which ones but it was single digits) would allow the machine to start
> thrashing. I could usually see that it was running out of memory and if I
> was fast enough could kill Netscape b4 the machine locked. If I was not
> fast enough it would lock hard. Nothing in the logs.
> 
> HTH,
> 
> -- 
> ......Tom	ATA100 is another testimony to the fact that pigs can be
> tdiehl@pil.net	made to fly given sufficient thrust (to borrow an RFC)
> 		Alan Cox lkml 11 Jan 01
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Tim Wright - timw@splhi.com or timw@aracnet.com or twright@us.ibm.com
IBM Linux Technology Center, Beaverton, Oregon
Interested in Linux scalability ? Look at http://lse.sourceforge.net/
"Nobody ever said I was charming, they said "Rimmer, you're a git!"" RD VI
