Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291164AbSBLU0P>; Tue, 12 Feb 2002 15:26:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291170AbSBLUZ4>; Tue, 12 Feb 2002 15:25:56 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:12050 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S291164AbSBLUZx>;
	Tue, 12 Feb 2002 15:25:53 -0500
Message-ID: <3C697A1D.4599DDE@zip.com.au>
Date: Tue, 12 Feb 2002 12:25:01 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jan Hudec <bulb@ucw.cz>
CC: linux-kernel@vger.kernel.org, Matt Gauthier <elleron@yahoo.com>
Subject: Re: secure erasure of files?
In-Reply-To: <Pine.LNX.4.30.0202121409150.18597-100000@mustard.heime.net> <Pine.LNX.4.33.0202121438560.7616-100000@unicef.org.yu> <20020212165504.A5915@devcon.net>,
		<20020212165504.A5915@devcon.net>; from aferber@techfak.uni-bielefeld.de on Tue, Feb 12, 2002 at 04:55:04PM +0100 <20020212204710.A7416@artax.karlin.mff.cuni.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Hudec wrote:
> 
> > I don't know if any filesystem currently relocates blocks if you
> > overwrite a file, but it's certainly possible and allowed (everything
> > else except the filesystem itself simply must not care where the data
> > actually ends up on the disk).
> 
> AFAIK, ext2 tries to defragment files when possible.

We wish.

> Thus if the file was
> fragmented and the blocks after some fragment are free, it will use these
> instead of the original ones somewhere far apart.

Nope - if you're overwriting a part of the file which already has
allocated blocks, ext2/3 will use the same blocks.

Of course, the disk itself may decide to go and remap the block
if it decides that part of the media is getting tired.

-
