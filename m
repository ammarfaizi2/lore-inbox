Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292780AbSCGW3a>; Thu, 7 Mar 2002 17:29:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290843AbSCGW3U>; Thu, 7 Mar 2002 17:29:20 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:38151 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S310556AbSCGW3C>;
	Thu, 7 Mar 2002 17:29:02 -0500
Date: Thu, 7 Mar 2002 19:27:49 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Arch option to touch newly allocated pages
In-Reply-To: <3C87E859.427EC3C7@zip.com.au>
Message-ID: <Pine.LNX.4.44L.0203071926340.2181-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Mar 2002, Andrew Morton wrote:

> > use-once reduces the VM to FIFO order, which suffers from
> > belady's anomaly so it doesn't matter much how much memory
> > you throw at it
> >
> > drop-behind will suffer the same problem once the readahead
> > memory is too large to keep in the system, but at least the
> > already-used pages won't kick out readahead pages
>
> err..  Was there a fix in there somewhere, or are we stuck?

Imagine how TCP backoff would work if it kept old packets
around and would drop random packets because of too many
old packets in the buffers.

I suspect that the readahead window resizing might work
when we throw away the already-used streaming IO pages
before we start throwing away any pages we're about to
use.

regards,

Rik
-- 
<insert bitkeeper endorsement here>

http://www.surriel.com/		http://distro.conectiva.com/

