Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273927AbRIRVIV>; Tue, 18 Sep 2001 17:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273928AbRIRVIL>; Tue, 18 Sep 2001 17:08:11 -0400
Received: from [208.48.139.185] ([208.48.139.185]:30878 "HELO
	forty.greenhydrant.com") by vger.kernel.org with SMTP
	id <S273927AbRIRVIC>; Tue, 18 Sep 2001 17:08:02 -0400
Date: Tue, 18 Sep 2001 14:08:20 -0700
From: David Rees <dbr@greenhydrant.com>
To: linux-kernel@vger.kernel.org
Subject: Re: bdflush and postgres stuck in D state
Message-ID: <20010918140820.A17263@greenhydrant.com>
Mail-Followup-To: David Rees <dbr@greenhydrant.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010918125605.F29908@unthought.net>, <20010918125605.F29908@unthought.net>; <20010918193023.P29908@unthought.net> <3BA78916.2984B011@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BA78916.2984B011@zip.com.au>; from akpm@zip.com.au on Tue, Sep 18, 2001 at 10:49:10AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2001 at 10:49:10AM -0700, Andrew Morton wrote:
> Jakob Østergaard wrote:
> > 
> > Sorry for following up on my own post, I have a little extra
> > information.
> > 
> > I started a g++ job to try to force the machine to write out some dirty
> > buffers before I reboot.   g++ now hangs along with two sync's, bdflush
> > and the postgres process.
> > 
> 
> Since 2.4.7 several bugs have been fixed in RAID1 which would
> cause this, including a missing blockdevice unplug and failure
> to hang onto the supposedly-reserved RAID1 buffer-heads.

Even kernels as recent as 2.4.9 have this bug.  See this thread for more
info and a patch which fixes this bug.

The thread:
http://marc.theaimsgroup.com/?t=99911655500004&w=2&r=1

The patch:
http://marc.theaimsgroup.com/?l=linux-kernel&m=99913223508789&w=2

-Dave
