Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291440AbSBMHlf>; Wed, 13 Feb 2002 02:41:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291438AbSBMHlP>; Wed, 13 Feb 2002 02:41:15 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:522 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S291436AbSBMHlM>; Wed, 13 Feb 2002 02:41:12 -0500
Date: Tue, 12 Feb 2002 23:30:46 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: Jens Axboe <axboe@suse.de>
cc: Vojtech Pavlik <vojtech@suse.cz>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Pavel Machek <pavel@suse.cz>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: another IDE cleanup: kill duplicated code
In-Reply-To: <20020213074214.S1907@suse.de>
Message-ID: <Pine.LNX.4.10.10202122327570.668-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Feb 2002, Jens Axboe wrote:

> On Tue, Feb 12 2002, Andre Hedrick wrote:
> > I just love how the copy of a request has worked its way back into to the
> > code-base. :-/  I recall Linus stating it was/is a horrid mess.
> 
> The copy itself is not the horrid mess, the handling of multi write is
> what is the horrible mess. Having a private copy to mess with is pretty
> much a necessity IMO if you want to handle > current_nr_sectors at the
> time without completing it chunk by chunk.

Exactly, and I am about to have a valid clean solution that is short and
proper.  Now that I have the handler working, I need to have the one walk
function to do the bio indexing.  Also it is less than 30 lines.

Not the stuff you added as an interm fix :-/

You know why these changes people are pushing are wrong, because it is way
to early to being the compression code process.

Cheers,

Andre Hedrick
Linux Disk Certification Project                Linux ATA Development

