Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289336AbSA1T1d>; Mon, 28 Jan 2002 14:27:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289338AbSA1T1X>; Mon, 28 Jan 2002 14:27:23 -0500
Received: from holomorphy.com ([216.36.33.161]:25497 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S289336AbSA1T1P>;
	Mon, 28 Jan 2002 14:27:15 -0500
Date: Mon, 28 Jan 2002 11:28:23 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Josh MacDonald <jmacd@CS.Berkeley.EDU>, linux-kernel@vger.kernel.org,
        reiserfs-list@namesys.com, reiserfs-dev@namesys.com
Subject: Re: Note describing poor dcache utilization under high memory pressure
Message-ID: <20020128112823.G899@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Rik van Riel <riel@conectiva.com.br>,
	Linus Torvalds <torvalds@transmeta.com>,
	Josh MacDonald <jmacd@CS.Berkeley.EDU>,
	linux-kernel@vger.kernel.org, reiserfs-list@namesys.com,
	reiserfs-dev@namesys.com
In-Reply-To: <Pine.LNX.4.33.0201281005480.1609-100000@penguin.transmeta.com> <Pine.LNX.4.33L.0201281626340.32617-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <Pine.LNX.4.33L.0201281626340.32617-100000@imladris.surriel.com>; from riel@conectiva.com.br on Mon, Jan 28, 2002 at 04:37:02PM -0200
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, 28 Jan 2002, Linus Torvalds wrote:
>> (Also, I'd like to understand why some people report so much better
>> times on dbench, and some people reports so much _worse_ times with
>> dbench. Admittedly dbench is a horrible benchmark, but still.. Is it
>> just the elevator breakage, or is it rmap itself?)

On Mon, Jan 28, 2002 at 04:37:02PM -0200, Rik van Riel wrote:
> We're still looking into this.  William Irwin is running a
> nice script to see if the settings in /proc/sys/vm/bdflush
> have an observable influence on dbench.

They have observable effects, but the preliminary results (the
runs are so time-intensive the repetitions needed to average out
dbench's wild fluctuations are going to take a while) seem to
give me three intuitions:

(1) the bdflush logic is brittle and/or not sufficiently adaptive
(2) dbench results fluctuate so wildly it's difficult to
	reproduce results accurately
(3) dbench results fluctuate so wildly it obscures the true
	performance curve

The winner of the first round seems to be 7 0 0 0 500 3000 28 0 0

Cheers,
Bill
