Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129507AbQKWQOw>; Thu, 23 Nov 2000 11:14:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129765AbQKWQOl>; Thu, 23 Nov 2000 11:14:41 -0500
Received: from Cantor.suse.de ([194.112.123.193]:34832 "HELO Cantor.suse.de")
        by vger.kernel.org with SMTP id <S129507AbQKWQOj>;
        Thu, 23 Nov 2000 11:14:39 -0500
Date: Thu, 23 Nov 2000 16:44:36 +0100
From: Andi Kleen <ak@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andries.Brouwer@cwi.nl, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org
Subject: Re: {PATCH} isofs stuff
Message-ID: <20001123164436.A17631@gruyere.muc.suse.de>
In-Reply-To: <UTC200011230350.EAA138908.aeb@aak.cwi.nl> <Pine.LNX.4.10.10011230727310.7927-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10011230727310.7927-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Thu, Nov 23, 2000 at 07:37:27AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2000 at 07:37:27AM -0800, Linus Torvalds wrote:
> > I have seen that there were discussions on the right compiler to use.
> > Is 2.95.2 wrong? Have other things to do tomorrow, so it will be
> > 24 hours before I can look at this again.
> 
> 2.95.2 should have been reasonably ok, but egcs-2.91.66 is probably
> considered the most stable compiler right now.
> 
> Note that gcc has always had problems with "long long" variables. Very few
> people use them as they aren't standard, and the code generation can be
> much trickier, so bugs are much more likely. This (along with performance
> issues) was why I refused the original LFS patches - they put "long long"
> code all over the place.

gcc 2.95.2 seems to have more problems with long long the egcs 1.1, I have
at least one test case where it miscompiles a variable long long shift.


-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
