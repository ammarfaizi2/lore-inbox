Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288211AbSAHSVW>; Tue, 8 Jan 2002 13:21:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288206AbSAHSVN>; Tue, 8 Jan 2002 13:21:13 -0500
Received: from holomorphy.com ([216.36.33.161]:25048 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S288208AbSAHSVD>;
	Tue, 8 Jan 2002 13:21:03 -0500
Date: Tue, 8 Jan 2002 10:20:37 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org, riel@surriel.com, mjc@kernel.org,
        bcrl@redhat.com, akpm@zip.com.au, phillips@bonn-fries.net
Subject: Re: hashed waitqueues
Message-ID: <20020108102037.J10391@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, riel@surriel.com, mjc@kernel.org,
	bcrl@redhat.com, akpm@zip.com.au, phillips@bonn-fries.net
In-Reply-To: <20020104094049.A10326@holomorphy.com> <E16MeqE-0001Ea-00@starship.berlin> <20020104173923.B10391@holomorphy.com> <E16Mgoj-0001Ew-00@starship.berlin> <20020104210611.C10391@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20020104210611.C10391@holomorphy.com>; from wli@holomorphy.com on Fri, Jan 04, 2002 at 09:06:11PM -0800
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 5, 2002 02:39 am, William Lee Irwin III wrote:
>>> 2 or 3 shift/adds is really not possible, the population counts of the
>>> primes in those ranges tends to be high, much to my chagrin.

On Sat, Jan 05, 2002 at 03:44:06AM +0100, Daniel Phillips wrote:
>> It doesn't really have to be a prime, being relatively prime is also 
>> good, i.e., not too many or too small factors.  Surely there's a multiplier 
>> in the right range with just two prime factors that can be computed with 3 
>> shift-adds.

The (theoretically) best 64-bit prime with 5 high bits I found is:

11673330234145374209 == 0xa200000000100001
which has continued fraction of p/2^64
	= 0,1,1,1,2,1,1,1,1,1,1,1073740799,2,1,1,1,1,6,1,1,5,1023,1,4,1,1,3,3

and the (theoretically) best 64-bit prime with 4 high bits I found is:
11529215046068994049 == 0xa000000000080001
which has continued fraction of p/2^64
	= 0,1,1,1,2,549754765313,1,1,1,1,1,4095,2,1,1,1,1,2,1,2

(the continued fractions terminate after the points given here)

Which of the two would be better should depend on whether the penalty
against the distribution for the sixth term of the 4-bit prime is worse
than the computational expense of the extra shift/add for the 5-bit prime.

I need to start benching this stuff.


Cheers,
Bill
