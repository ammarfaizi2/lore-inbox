Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271082AbRHTNhn>; Mon, 20 Aug 2001 09:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271094AbRHTNhd>; Mon, 20 Aug 2001 09:37:33 -0400
Received: from shed.alex.org.uk ([195.224.53.219]:28645 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S271082AbRHTNh0>;
	Mon, 20 Aug 2001 09:37:26 -0400
Date: Mon, 20 Aug 2001 14:37:34 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Oliver Xymoron <oxymoron@waste.org>, Theodore Tso <tytso@mit.edu>
Cc: David Schwartz <davids@webmaster.com>,
        Andreas Dilger <adilger@turbolinux.com>, linux-kernel@vger.kernel.org,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: /dev/random in 2.4.6
Message-ID: <2247427940.998318254@[10.132.112.53]>
In-Reply-To: <Pine.LNX.4.30.0108191808350.740-100000@waste.org>
In-Reply-To: <Pine.LNX.4.30.0108191808350.740-100000@waste.org>
X-Mailer: Mulberry/2.1.0b3 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Can I propose an add_untrusted_randomness()? This would work identically
> to add_timer_randomness but would pass batch_entropy_store() 0 as the
> entropy estimate. The store would then be made to drop 0-entropy elements
> on the floor if the queue was more than, say, half full. This would let us
> take advantage of 'potential' entropy sources like network interrupts and
> strengthen /dev/urandom without weakening /dev/random.

Am I correct in assuming that in the absence of other entropy sources, it
would use these (potentially inferior) sources, and /dev/random would
then not block? In which case fine, it solves my problem.

--
Alex Bligh
