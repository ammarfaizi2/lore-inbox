Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269238AbRGaKbo>; Tue, 31 Jul 2001 06:31:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269240AbRGaKbd>; Tue, 31 Jul 2001 06:31:33 -0400
Received: from weta.f00f.org ([203.167.249.89]:34438 "HELO weta.f00f.org")
	by vger.kernel.org with SMTP id <S269238AbRGaKbX>;
	Tue, 31 Jul 2001 06:31:23 -0400
Date: Tue, 31 Jul 2001 22:32:03 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Hans Reiser <reiser@namesys.com>
Cc: Rik van Riel <riel@conectiva.com.br>, Christoph Hellwig <hch@caldera.de>,
        linux-kernel@vger.kernel.org
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
Message-ID: <20010731223203.B7257@weta.f00f.org>
In-Reply-To: <Pine.LNX.4.33L.0107301904060.5582-100000@duckman.distro.conectiva> <3B65E177.D77ACA45@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B65E177.D77ACA45@namesys.com>
User-Agent: Mutt/1.3.18i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Tue, Jul 31, 2001 at 02:36:39AM +0400, Hans Reiser wrote:

    If you could halve linux memory manager performance and check as
    many things as reiserfs checks, would you do it.  I think not, or
    else you would have.  You made the right choice.  Now, if you add
    a #define, you can check as many things as ReiserFS checks, and
    still go just as fast....

The memory manager is stress much more often that reiserfs, EVERYBODY
has it.

The MM system does have various sanity checks, things might be
slightly faster without them, but having the sanity checks is still
very important.

If the memory manager does something bad, chances are your system will
go boom --- upon reboot all is happy.  If as fs goes bad, that
corruption might still be there when you reboot, even if to another
kernel!  This is a major difference.

Anyhow, I use resierfs with debugging/checking on in lots of places.
The speed difference is negligible, so I think this whole thread is
pointless.

FWIW, if the mainline kernels remove the debugging option, I will hack
it back in --- I for one am happy with the performance and am pleased
there is additional sanity checking.






  --cw

