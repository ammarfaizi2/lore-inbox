Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261393AbSJIItH>; Wed, 9 Oct 2002 04:49:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261512AbSJIItH>; Wed, 9 Oct 2002 04:49:07 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:47253 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261393AbSJIItG>;
	Wed, 9 Oct 2002 04:49:06 -0400
Date: Wed, 9 Oct 2002 10:54:41 +0200
From: Jens Axboe <axboe@suse.de>
To: lell02 <lell02@stud.uni-passau.de>
Cc: Tommy Vestermark <tov@mail1.stofanet.dk>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Status of UDF CD packet writing?
Message-ID: <20021009085441.GA838@suse.de>
References: <200210082152.g98LqFjm015242@tom.rz.uni-passau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210082152.g98LqFjm015242@tom.rz.uni-passau.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08 2002, lell02 wrote:
> hi, 
> 
> >Will Jens Axboes patch for CD packet writing for CD-R/RW make it in
> >before the feature freeze? I know Jens Axboe is busy with more basic I/O
> >stuff, but i sincerely hope it can be squeezed in before 2.6/3.0 is
> >released.
> 
> jens stated on this about 1-2 days ago. he said, it would be little
> modification on the ide-cdrom, to make it work with cd-mrw/ packet
> writing.  so it could go in after the feature freeze.

You might be talking about two different patches -- one for cd-rw
support (this is the pktcdvd (or -packet) patch that Peter Osterlund has
been maintaining) and the other for cd-mrw. The cd-mrw patch is very
small, not a lot is required to support that in the cd driver.
Supporting cd-rw is a lot harder, basically you have to do in software
what cd-mrw does in hardware (defect management, read-modify-write
packet gathering, etc).

cd-mrw will definitely be in 2.6. cd-rw support maybe, I haven't even
looked at that lately.

-- 
Jens Axboe

