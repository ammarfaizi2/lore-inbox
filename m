Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286895AbSBIUVg>; Sat, 9 Feb 2002 15:21:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287111AbSBIUV0>; Sat, 9 Feb 2002 15:21:26 -0500
Received: from shed.alex.org.uk ([195.224.53.219]:24267 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S286895AbSBIUVI>;
	Sat, 9 Feb 2002 15:21:08 -0500
Date: Sat, 09 Feb 2002 20:21:01 -0000
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Daniel Phillips <phillips@bonn-fries.net>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, zaitcev@redhat.com
Cc: linux-kernel@vger.kernel.org,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: The IBM order relaxation patch
Message-ID: <2345050357.1013286061@[195.224.237.69]>
In-Reply-To: <E16YpHW-0000aw-00@starship.berlin>
In-Reply-To: <E16YpHW-0000aw-00@starship.berlin>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Thursday, 07 February, 2002 3:12 PM +0100 Daniel Phillips 
<phillips@bonn-fries.net> wrote:

> Maybe Rik's
>> rmap method could help here, because with reverse mappings we
>> can at least try to free adjacent areas (because we then at least
>> *know* who's using the pages).
>
> Yes, that's one of leading reasons for wanting rmap.  (Number one and two
> reasons are: allow forcible unmapping of multiply referenced pages for
> swapout; get more reliable hardware ref bit readings.)
>
> Note that even if we can do forcible freeing we still have to deal with
> the  issue of fragmentation due to pinned pages, e.g., slab cache,
> admittedly a  rarer problem.

Perhaps mitigated if you use the same technology as you are using to do the
freeing, to ensure that pinned pages (slab cache etc.) are preferentially
allocated next to other pinned pages.

--
Alex Bligh
