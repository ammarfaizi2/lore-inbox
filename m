Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271580AbRIFTw1>; Thu, 6 Sep 2001 15:52:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272534AbRIFTwR>; Thu, 6 Sep 2001 15:52:17 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:20484 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S271580AbRIFTwL>; Thu, 6 Sep 2001 15:52:11 -0400
Date: Thu, 6 Sep 2001 16:52:05 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Kurt Garloff <garloff@suse.de>, Jan Harkes <jaharkes@cs.cmu.edu>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        <linux-kernel@vger.kernel.org>
Subject: Re: page_launder() on 2.4.9/10 issue
In-Reply-To: <20010906193836Z16130-26183+40@humbolt.nl.linux.org>
Message-ID: <Pine.LNX.4.33L.0109061650250.8103-100000@duckman.distro.conectiva>
X-supervisor: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Sep 2001, Daniel Phillips wrote:

> Again, I have to ask, which reads are you interfering with?  Ones that
> haven't happened yet?  Remember, the disk is idle.  So *at worst* you are
> going to get one extra seek before getting hit with the tidal wave of reads
> you seem to be worried about.  This simply isn't significant.
>
> I've tested this, I know early writeout under light load is a win.

Other people have tested this too, and light writeout of
small blocks destroys the performance of a heavy read
load.

> What we should be worrying about is how to balance reads against
> writes under heavy load.

Exactly. We need to make sure we're efficient when the
system is under heavy read load and light write load.
This kind of load is very common in servers, especially
web, ftp or news servers.

regards,

Rik
--
IA64: a worthy successor to the i860.

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

