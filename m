Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270692AbRHJX5x>; Fri, 10 Aug 2001 19:57:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270693AbRHJX5f>; Fri, 10 Aug 2001 19:57:35 -0400
Received: from weta.f00f.org ([203.167.249.89]:39057 "EHLO weta.f00f.org")
	by vger.kernel.org with ESMTP id <S270692AbRHJX5W>;
	Fri, 10 Aug 2001 19:57:22 -0400
Date: Sat, 11 Aug 2001 11:58:27 +1200
From: Chris Wedgwood <cw@f00f.org>
To: "David S. Miller" <davem@redhat.com>
Cc: lm@bitmover.com, torvalds@transmeta.com, frankeh@us.ibm.com,
        mkravetz@beaverton.ibm.com, linux-kernel@vger.kernel.org,
        wscott@bitmover.com
Subject: Re: [RFC][PATCH] Scalable Scheduling
Message-ID: <20010811115827.A1395@weta.f00f.org>
In-Reply-To: <Pine.LNX.4.33.0108081041260.8047-100000@penguin.transmeta.com> <Pine.LNX.4.33.0108081058420.8103-100000@penguin.transmeta.com> <20010808111844.S23718@work.bitmover.com> <200108081853.LAA02747@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200108081853.LAA02747@pizda.ninka.net>
User-Agent: Mutt/1.3.20i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2001 at 11:53:28AM -0700, David S. Miller wrote:

    1) tell me D-cache misses in user and/or kernel mode
    2) tell me D-cache misses that hit the E-cache
       in user and/or kernel mode
    3) tell me I-cache misses, but only those which actually
       ended up stalling the pipeline
    4) tell me E-cache misses, where the chip was not able
       to get granted to memory bus immediately
    5) Same as #4, but how many total bus cycles were spent
       waiting for bus grant for the E-cache miss

ia32 for PPro and above can do all of that too pretty much (perhaps
not exactly the same metric, but hopefully equally useful).  The only
thing is, you can read them all at once, only a small number of them,
and they are for all kernel/userland states, so you would need to
save/read them on context switches.



  --cw

