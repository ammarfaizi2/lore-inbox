Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273099AbRIRRtM>; Tue, 18 Sep 2001 13:49:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273110AbRIRRtC>; Tue, 18 Sep 2001 13:49:02 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:6150 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S273099AbRIRRsq>; Tue, 18 Sep 2001 13:48:46 -0400
Message-ID: <3BA78916.2984B011@zip.com.au>
Date: Tue, 18 Sep 2001 10:49:10 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10-pre11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jakob =?iso-8859-1?Q?=D8stergaard?= <jakob@unthought.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: bdflush and postgres stuck in D state
In-Reply-To: <20010918125605.F29908@unthought.net>,
		<20010918125605.F29908@unthought.net>; from jakob@unthought.net on Tue, Sep 18, 2001 at 12:56:05PM +0200 <20010918193023.P29908@unthought.net>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jakob Østergaard wrote:
> 
> Sorry for following up on my own post, I have a little extra
> information.
> 
> I started a g++ job to try to force the machine to write out some dirty
> buffers before I reboot.   g++ now hangs along with two sync's, bdflush
> and the postgres process.
> 

Since 2.4.7 several bugs have been fixed in RAID1 which would
cause this, including a missing blockdevice unplug and failure
to hang onto the supposedly-reserved RAID1 buffer-heads.

-
