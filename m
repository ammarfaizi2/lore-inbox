Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272656AbRIPSRD>; Sun, 16 Sep 2001 14:17:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272659AbRIPSQy>; Sun, 16 Sep 2001 14:16:54 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:10765 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S272656AbRIPSQf>; Sun, 16 Sep 2001 14:16:35 -0400
Date: Sun, 16 Sep 2001 20:16:52 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Christoph Hellwig <hch@caldera.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.10pre7aa1
Message-ID: <20010916201652.A1315@athlon.random>
In-Reply-To: <20010916192316.A13248@athlon.random> <Pine.LNX.4.33L.0109161433530.9536-100000@imladris.rielhome.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L.0109161433530.9536-100000@imladris.rielhome.conectiva>; from riel@conectiva.com.br on Sun, Sep 16, 2001 at 02:34:55PM -0300
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 16, 2001 at 02:34:55PM -0300, Rik van Riel wrote:
> On Sun, 16 Sep 2001, Andrea Arcangeli wrote:
> 
> > However the issue with keventd and the fact we can get away with a
> > single per-cpu counter increase in the scheduler fast path made us to
> > think it's cleaner to just spend such cycle for each schedule rather
> > than having yet another 8k per cpu wasted and longer taskslists (a
> > local cpu increase is cheaper than a conditional jump).
> 
> So why don't we put the test+branch inside keventd ?

first keventd runs non RT, second it slowsdown keventd but I agree that
would be a minor issue. The best approch to me seems the one I
outlined in the last email (per-cpu sequence counter as only additional
cost in schedule).

Andrea
