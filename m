Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261756AbREPBbF>; Tue, 15 May 2001 21:31:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261757AbREPBaz>; Tue, 15 May 2001 21:30:55 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:32019 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261756AbREPBar>; Tue, 15 May 2001 21:30:47 -0400
From: "H. Peter Anvin" <hpa@transmeta.com>
Message-ID: <3B01D82B.8CAE38B5@transmeta.com>
Date: Tue, 15 May 2001 18:30:19 -0700
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Anton Altaparmakov <aia21@cam.ac.uk>
CC: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: Getting FS access events
In-Reply-To: <200105152231.f4FMVSC246046@saturn.cs.uml.edu> <5.1.0.14.2.20010516020702.00acce40@pop.cus.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov wrote:
> 
> And how are you thinking of this working "without introducing new
> interfaces" if the caches are indeed incoherent? Please correct me if I
> understand wrong, but when two caches are incoherent, I thought it means
> that the above _would_ screw up unless protected by exclusive write locking
> as I suggested in my previous post with the side effect that you can't
> write the boot block without unmounting the filesystem or modifying some
> interface somewhere.
> 

Not if direct device acess and the superblock exist in the same mapping
space, OR an explicit interface to write the boot block is created.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
