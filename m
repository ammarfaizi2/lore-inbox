Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273937AbRISHZ7>; Wed, 19 Sep 2001 03:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273958AbRISHZk>; Wed, 19 Sep 2001 03:25:40 -0400
Received: from h24-78-175-24.vn.shawcable.net ([24.78.175.24]:39052 "EHLO
	oof.localnet") by vger.kernel.org with ESMTP id <S273937AbRISHZe>;
	Wed, 19 Sep 2001 03:25:34 -0400
Date: Wed, 19 Sep 2001 00:24:39 -0700
From: Simon Kirby <sim@netnation.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: O_NONBLOCK on files
Message-ID: <20010919002439.A21138@netnation.com>
In-Reply-To: <20010918234648.A21010@netnation.com> <m1r8t3fyot.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1r8t3fyot.fsf@frodo.biederman.org>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2001 at 01:05:06AM -0600, Eric W. Biederman wrote:

> Besides the SUS or the POSIX specs...

Yeah, well, blah.

> What would cause the data to be read in if read just checks the caches?
> With sockets the other side is clearing pushing or pulling the data.  With
> files there is no other side...

Hmm...Without even thinking about it, I assumed it would start a read and
select() or poll() or some later call would return readable when my
outstanding request was fulfilled.  But yes, I guess you're right, this is
different behavior because there is no other side.

Reading a file would need a receive queue to make this work, I guess. :)

Simon-

[  Stormix Technologies Inc.  ][  NetNation Communications Inc. ]
[       sim@stormix.com       ][       sim@netnation.com        ]
[ Opinions expressed are not necessarily those of my employers. ]
