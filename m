Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310584AbSCPUXB>; Sat, 16 Mar 2002 15:23:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310597AbSCPUWn>; Sat, 16 Mar 2002 15:22:43 -0500
Received: from ns.suse.de ([213.95.15.193]:48393 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S310584AbSCPUWa>;
	Sat, 16 Mar 2002 15:22:30 -0500
Date: Sat, 16 Mar 2002 21:22:29 +0100
From: Andi Kleen <ak@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: yodaiken@fsmlabs.com, Andi Kleen <ak@suse.de>,
        Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: 10.31 second kernel compile
Message-ID: <20020316212229.B25796@wotan.suse.de>
In-Reply-To: <20020316125711.B20436@hq.fsmlabs.com> <Pine.LNX.4.33.0203161203050.31971-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0203161203050.31971-100000@penguin.transmeta.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 16, 2002 at 12:14:06PM -0800, Linus Torvalds wrote:
> Oh, and in the specific case of hammer, one of the main advantages of the 
> thing is of course running old binaries unchanged. And old binaries 
> certainly do mmap's at smaller granularity than 2M (and have to, because a 
> 3G user address space won't fit all that many 2M chunks).

The idea was to only map selected mappings using large pages, e.g. shared
memory mappings to help all the databases or use a special mmap flag 
for the Beowulf people. 

> Give up on large pages - it's just not happening. Even when a 64kB page 
> would make sense from a technology standpoint these days, backwards 
> compatibility makes people stay at 4kB.

Yes the 4KB page has to be kept at least for now. 

-ANdi
