Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288325AbSBMS1y>; Wed, 13 Feb 2002 13:27:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288308AbSBMS1p>; Wed, 13 Feb 2002 13:27:45 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:53245
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S288325AbSBMS13>; Wed, 13 Feb 2002 13:27:29 -0500
Date: Wed, 13 Feb 2002 10:27:41 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: secure erasure of files?
Message-ID: <20020213182741.GA335@matchmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0202121409150.18597-100000@mustard.heime.net> <Pine.LNX.4.33.0202121438560.7616-100000@unicef.org.yu> <20020212165504.A5915@devcon.net> <3C6A32ED.755159F3@aitel.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C6A32ED.755159F3@aitel.hist.no>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2002 at 10:33:33AM +0100, Helge Hafting wrote:
> Andreas Ferber wrote:
> 
> > I don't know if any filesystem currently relocates blocks if you
> > overwrite a file, but it's certainly possible and allowed (everything
> > else except the filesystem itself simply must not care where the data
> > actually ends up on the disk).
> > 
> A log-structured fs will write new blocks everytime, afaik.

Ext3 only does that on truncate in ordered/writeback mode and probably in
data journaling mode too.

> Ext3 with data journalling keeps copies of recently written data
> in the journal.  Now, if you create a "secret" file and then overwrite
> it you'll still find a copy in the journal until the journal wraps
> It may not wrap if the next thing you do is umount/shutdown.
>
> A secure rm must know the fs it works with.  A better solution
> is to overwrite the entire partition with garbage. The only
> perfect way is to destroy the magnetic surfaces though.
>

Yep, very true.

Phycally breaking the drive apart into pieces and then burning should
suffice. 

Mike
