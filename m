Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261713AbSJIKj6>; Wed, 9 Oct 2002 06:39:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261719AbSJIKj6>; Wed, 9 Oct 2002 06:39:58 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:64418 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261713AbSJIKj5>;
	Wed, 9 Oct 2002 06:39:57 -0400
Date: Wed, 9 Oct 2002 12:45:37 +0200
From: Jens Axboe <axboe@suse.de>
To: lell02 <lell02@stud.uni-passau.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Status of UDF CD packet writing?
Message-ID: <20021009104537.GD620@suse.de>
References: <200210091042.g99Agwjm009964@tom.rz.uni-passau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210091042.g99Agwjm009964@tom.rz.uni-passau.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09 2002, lell02 wrote:
> >On Tue, Oct 08 2002, lell02 wrote:
> >> hi, 
> >> 
> >> >Will Jens Axboes patch for CD packet writing for CD-R/RW make it in
> >> >before the feature freeze? I know Jens Axboe is busy with more basic I/O
> >> >stuff, but i sincerely hope it can be squeezed in before 2.6/3.0 is
> >> >released.
> >> 
> >> jens stated on this about 1-2 days ago. he said, it would be little
> >> modification on the ide-cdrom, to make it work with cd-mrw/ packet
> >> writing.  so it could go in after the feature freeze.
> >
> >You might be talking about two different patches -- one for cd-rw
> >support (this is the pktcdvd (or -packet) patch that Peter Osterlund has
> >been maintaining) and the other for cd-mrw. The cd-mrw patch is very
> >small, not a lot is required to support that in the cd driver.
> >Supporting cd-rw is a lot harder, basically you have to do in software
> >what cd-mrw does in hardware (defect management, read-modify-write
> >packet gathering, etc).
> >
> >cd-mrw will definitely be in 2.6. cd-rw support maybe, I haven't even
> >looked at that lately.
> >
> 
> thanx for clearing out these differences. 
> 
> but, isn't cd-mrw supposed to replace the old packet-writing
> technique?  so, in the end, there wouldn't be any need for
> packet-writing, if every burner ships with cd-mrw-support... i read in
> the "specs", that the technology would be much better.

(btw, please break your lines at 72 chars or similar)

Yeah that is true, the need for the cd-rw packet writing patch should
diminish once cd-mrw is in all drives.

-- 
Jens Axboe

