Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271260AbRHTOyJ>; Mon, 20 Aug 2001 10:54:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271265AbRHTOxu>; Mon, 20 Aug 2001 10:53:50 -0400
Received: from h131s117a129n47.user.nortelnetworks.com ([47.129.117.131]:9887
	"HELO pcard0ks.ca.nortel.com") by vger.kernel.org with SMTP
	id <S271260AbRHTOxb>; Mon, 20 Aug 2001 10:53:31 -0400
Message-ID: <3B8124C4.7A4275B9@nortelnetworks.com>
Date: Mon, 20 Aug 2001 10:55:00 -0400
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-custom i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        Oliver Xymoron <oxymoron@waste.org>, Theodore Tso <tytso@mit.edu>,
        David Schwartz <davids@webmaster.com>,
        Andreas Dilger <adilger@turbolinux.com>
Subject: Re: /dev/random in 2.4.6
In-Reply-To: <Pine.LNX.4.30.0108200903580.4612-100000@waste.org> <2251207905.998322034@[10.132.112.53]>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Bligh - linux-kernel wrote:

> An alternative approach to all of this, perhaps, would be to use extremely
> finely grained timers (if they exist), in which case more bits of entropy
> could perhaps be derived per sample, and perhaps sample them on
> more operations. I don't know what the finest resolution timer we have
> is, but I'd have thought people would be happier using ANY existing
> mechanism (including network IRQs) if the timer resolution was (say)
> 1 nanosecond.

Why don't we also switch to a cryptographically secure algorithm for
/dev/urandom?  Then we could seed it with a value from /dev/random and we would
have a known number of cryptographically secure pseudorandom values.  Once we
reach the end of the png cycle, we could re-seed it with another value from
/dev/random.

Would this be a valid solution, or am I totally off my rocker?

Chris


-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
