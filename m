Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311025AbSEPOVj>; Thu, 16 May 2002 10:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312962AbSEPOVi>; Thu, 16 May 2002 10:21:38 -0400
Received: from mta9n.bluewin.ch ([195.186.1.215]:11094 "EHLO mta9n.bluewin.ch")
	by vger.kernel.org with ESMTP id <S311025AbSEPOVh>;
	Thu, 16 May 2002 10:21:37 -0400
Date: Thu, 16 May 2002 16:19:44 +0200
From: Roger Luethi <rl@hellgate.ch>
To: "Ivan G." <ivangurdiev@linuxfreemail.com>
Cc: Urban Widmark <urban@teststation.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] VIA Rhine stalls: TxAbort handling
Message-ID: <20020516141944.GB31759@k3.hellgate.ch>
In-Reply-To: <20020514035318.GA20088@k3.hellgate.ch> <02051317475500.00917@cobra.linux> <20020516004927.GA13388@k3.hellgate.ch> <02051515523500.01017@cobra.linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux 2.4.19-pre8 on i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 May 2002 15:52:35 -0600, Ivan G. wrote:
> The slowdown I was talking about was actually with the new abort/underrun 
> handling - I had tried it by myself before your patch. That's the what that 
> quote was about. I think I handled both Abort and Underrun like that.
> I'll try that new patch that you're making to retest.

How a different abort handling could cause a slow down is beyond me,
especially if you used the old code where the aborted frame got
reactivated. With the vanilla code, you were bound to stall on the first tx
error, which should certainly decrease troughput by a fair bit. And unless
a tx error occurs, both versions (of the code) behave identically. I'm
afraid I don't understand what's going on with the VT86C100A.

> On Urban's question,  I test without MMIO so this is not a related issue. I 
> was merely curious since I don't feel comfortable trusting something which
> A) does not match any of the other Rhine-based cards (2's and 3's)
> B) says RESERVED in the docs which I have.
> 
> Funny, I was going to send you a link to the newer docs, but I ran into the 
> older ones which I had never seen before. Yes, they do agree with the current 
> code. Hmm. Perhaps we should ask VIA why it was changed...

I'd take the docs with a grain of salt, especially the VT86C100A data sheet
(the one I have, anyway) contains so blatant mistakes it's downright
confusing.

Roger
