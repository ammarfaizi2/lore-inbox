Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290433AbSA3Shq>; Wed, 30 Jan 2002 13:37:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290419AbSA3SgM>; Wed, 30 Jan 2002 13:36:12 -0500
Received: from holomorphy.com ([216.36.33.161]:30883 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S290417AbSA3SfZ>;
	Wed, 30 Jan 2002 13:35:25 -0500
Date: Wed, 30 Jan 2002 10:37:19 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org,
        Knut Olav Boehmer <knuto@linpro.no>,
        Frank Ronny Larsen <gobo@gimle.nu>
Subject: Re: still problems with heavy i/o load
Message-ID: <20020130183719.GA24132@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
	Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org,
	Knut Olav Boehmer <knuto@linpro.no>,
	Frank Ronny Larsen <gobo@gimle.nu>
In-Reply-To: <Pine.LNX.4.30.0201301825470.31732-100000@mustard.heime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.30.0201301825470.31732-100000@mustard.heime.net>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2002 at 06:42:38PM +0100, Roy Sigurd Karlsbakk wrote:
> I don't know what this might be, but still, now on -rmap12a, i get the
> following behaviour:
> * streaming starts
> * speed is initially >40MB/s
> * when cache is used up, it falls to ~30MB/s - then (after a while) down
>   to ~25MB/s
> * then down to 0, which might show the wget processes on the remote
>   computer should be finished, but they aren't. They (59 of the original
>   100) are in Sleeping state. The server won't push more data.
> This problem is _not_ rmap specific, as mentioned in
> http://karlsbakk.net/dev/kernel/vm-fsckup.txt. With 2.4.17-vanilla, the
> data transfer halts after reading 2xRAM bytes.

This is very strange. Is the client machine constant? What kernel does
it use? Is it reproducible against multiple client kernels? This sounds
like a fairly serious regression. Are you always using tux as the httpd?
What about other httpd's?

On Wed, Jan 30, 2002 at 06:42:38PM +0100, Roy Sigurd Karlsbakk wrote:
> strangely, rmap11c seems to be quite stable, but only gives me ~32MB/s,
> whereas the initial is close to 50.
> I have posted mesages about this bug so many times now, that I really soon
> will try to install CP/M or something. At least a stable system!
> And - yes! - I have tried Andrea's patches. The only fscking thing that
> seems to be close to solving it is rmap11c
> Please help me about this

I will at least attempt to reproduce this behavior. I'm suspicious that
the problem could lie in a dark corner only tangentially VM-related, as
you seem to be able to reproduce it under a variety of VM's.


Cheers,
Bill
