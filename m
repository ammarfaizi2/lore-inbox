Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273176AbRIJDCS>; Sun, 9 Sep 2001 23:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273175AbRIJDCI>; Sun, 9 Sep 2001 23:02:08 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:11206
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S273173AbRIJDB7>; Sun, 9 Sep 2001 23:01:59 -0400
Date: Sun, 09 Sep 2001 23:02:18 -0400
From: Chris Mason <mason@suse.com>
To: Daniel Phillips <phillips@bonn-fries.net>,
        Andrea Arcangeli <andrea@suse.de>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Andreas Dilger <adilger@turbolabs.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.4.10-pre5
Message-ID: <1381380000.1000090938@tiny>
In-Reply-To: <20010910023312Z16066-26183+700@humbolt.nl.linux.org>
In-Reply-To: <20010910001556Z16150-26183+680@humbolt.nl.linux.org>
 <20010910021513Z16066-26183+696@humbolt.nl.linux.org>
 <1324600000.1000088434@tiny>
 <20010910023312Z16066-26183+700@humbolt.nl.linux.org>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Monday, September 10, 2001 04:40:21 AM +0200 Daniel Phillips
<phillips@bonn-fries.net> wrote:

>> How about subsequent calls for the same offset with the same blocksize
>> need to return the same buffer head?
> 
> Are we picking nits?  Better add "the same dev" and "until the buffer
> head is  freed" ;-)

;-)  Really, wasn't trying for that.  If we just say later calls for the
same offset, we get in trouble later on if we also want variable, very
large blocksizes.  If we relax the rules to allow multiple buffer heads for
the same physical spot on disk, things get easier, and the FS is
responsible for not doing something stupid with it.  

The data is still consistent either way, there are just multiple io handles.

-chris

