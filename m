Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132500AbRDWWrc>; Mon, 23 Apr 2001 18:47:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132502AbRDWWr1>; Mon, 23 Apr 2001 18:47:27 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:25606 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S132500AbRDWWqE>;
	Mon, 23 Apr 2001 18:46:04 -0400
Date: Tue, 24 Apr 2001 00:45:35 +0200
From: Jens Axboe <axboe@suse.de>
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
Cc: Guest section DW <dwguest@win.tue.nl>, linux-kernel@vger.kernel.org
Subject: Re: 3-Ware Raid driver fails to update GenDisk head
Message-ID: <20010424004535.V9357@suse.de>
In-Reply-To: <20010423120852.A32097@vger.timpanogas.org> <20010423214701.A18855@win.tue.nl> <20010423135500.B32378@vger.timpanogas.org> <20010423231312.A18870@win.tue.nl> <20010423163212.A1131@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010423163212.A1131@vger.timpanogas.org>; from jmerkey@vger.timpanogas.org on Mon, Apr 23, 2001 at 04:32:12PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23 2001, Jeff V. Merkey wrote:
> On Mon, Apr 23, 2001 at 11:13:12PM +0200, Guest section DW wrote:
> > On Mon, Apr 23, 2001 at 01:55:00PM -0600, Jeff V. Merkey wrote:
> > > On Mon, Apr 23, 2001 at 09:47:01PM +0200, Guest section DW wrote:
> > > > On Mon, Apr 23, 2001 at 12:08:52PM -0600, Jeff V. Merkey wrote:
> > > > > 
> > > > > I am still working on this, but would appreciate some help from
> > > > > whomever owns this driver proper.  I have discovered that the 
> > > > > 3Ware drivers are not updating the gendisk_head with devices
> > > > > reported and exposed to user space as /dev/sda, sdb, etc.
> > > > 
> > > > But that is the job of sd.c, not of a driver.
> > > 
> > > These drivers are an IDE driver that simulates a SCSI interface.  It 
> > > reported IDE devices as SCSI handles, so there's some holes.  I guess
> > > you were not aware of this, or you would have known that standard sd.c
> > > is not working.
> > 
> > Just like ide-scsi.c you mean?
> 
> No.  They're not that clean and well organized, though they are rather 
> clever adapters and are pretty cool.

Come on Jeff, what Andries is saying is that it _works_ like ide-scsi.
It registers itself as a SCSI hba like a "regular" SCSI card, hence it
uses the SCSI infrastructure -- alas, disks driven by sd.c

-- 
Jens Axboe

