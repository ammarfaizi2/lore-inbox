Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261973AbTIMGbQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 02:31:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262054AbTIMGbQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 02:31:16 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:33155 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261973AbTIMGbP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 02:31:15 -0400
Date: Sat, 13 Sep 2003 08:29:18 +0200
From: Jens Axboe <axboe@suse.de>
To: Wes Janzen <superchkn@sbcglobal.net>
Cc: Stuart Longland <stuartl@longlandclan.hopto.org>,
       iain d broadfoot <ibroadfo@cis.strath.ac.uk>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: getting a working CD-drive in 2.6
Message-ID: <20030913062918.GC18553@suse.de>
References: <20030912093837.GC2921@iain-vaio-fx405> <3F627C13.6020608@longlandclan.hopto.org> <3F628811.1010209@sbcglobal.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F628811.1010209@sbcglobal.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 12 2003, Wes Janzen wrote:
> Hi,
> 
> Stuart Longland wrote:
> 
> >iain d broadfoot wrote:
> >
> >|     ide-scsi is disabled.
> >
> >If it's an IDE drive, you'll want this _enabled_ before you'll be able
> >to write CDs.  Most of the burner software that I know of look for a
> >SCSI CD burner, not IDE.  ide-scsi is intended for making an IDE CD
> >burner appear as a SCSI device.
> 
> 
> Actually with 2.6, you no longer need ide-scsi.  You'll need to upgrade 
> your cdrecord tools and probably your burning GUI, if you use one.  I've 
> been burning that way for several months now.  (I'm using xcdroast, 
> though I need to start it with "-n" since I'm using cdrecord 2.01a18.)  
> This actually works better for me than ide-scsi as for some reason it 
> uses less CPU.

That's because it _is_ faster. It contains no silly memory allocations
for the buffer and data copying in the kernel, the data is mapped from
the user buffer and DMA'ed directly from there. It also uses DMA where
ide-scsi wont.

People generally report that they have no problems burning at full speed
(52) on even really old machines where ide-scsi maxed out long before.

-- 
Jens Axboe

