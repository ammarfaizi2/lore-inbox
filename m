Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129093AbRBNN1p>; Wed, 14 Feb 2001 08:27:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132051AbRBNN1f>; Wed, 14 Feb 2001 08:27:35 -0500
Received: from garlic.amaranth.net ([216.235.243.195]:22027 "EHLO
	garlic.amaranth.net") by vger.kernel.org with ESMTP
	id <S129093AbRBNN1a>; Wed, 14 Feb 2001 08:27:30 -0500
Message-ID: <3A8A87A7.4A3CE58D@egenera.com>
Date: Wed, 14 Feb 2001 08:27:03 -0500
From: Phil Auld <pauld@egenera.com>
Organization: Egenera Inc.
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.2.16-3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: Stale super_blocks in 2.2
In-Reply-To: <E14So5t-00038p-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > That can be a problem for fiber channel devices. I saw some issues with
> > invalidate_buffers and page caching discussed in 2.4 space. Any reasons
> > come to mind why I shouldn't call invalidate on the the way down instead
> > (or in addition)?
> 
> The I/O completed a few seconds later anyway when bdflush got around to
> writing the data back out. I dont plan to change 2.2. 2.4 doesnt do that
> optimisation which is annoying in a few cases and a lot less suprising in
> others

Sure, the I/O completes, but the buffer_head is still in memory, valid and
uptodate.
On a subsequent mount the super_block comes from memory not disk. This works
as long as nobody else mounted that file system in between. 

I can make the changes needed. I was really curious if you, or anyone else,
thought there might be page caching issues involved with invalidating on the way
down.

Thanks the time,

Phil


------------------------------------------------------
Philip R. Auld,Ph.D.                  Techinical Staff
Egenera Corp.                        pauld@egenera.com
165 Forest St, Marlboro, MA 01752        (508)786-9444
