Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267657AbRHARkc>; Wed, 1 Aug 2001 13:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267651AbRHARkV>; Wed, 1 Aug 2001 13:40:21 -0400
Received: from yoda.planetinternet.be ([195.95.30.146]:40719 "EHLO
	yoda.planetinternet.be") by vger.kernel.org with ESMTP
	id <S267772AbRHARkL>; Wed, 1 Aug 2001 13:40:11 -0400
Date: Wed, 1 Aug 2001 19:40:06 +0200
From: Kurt Roeckx <Q@ping.be>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext3-2.4-0.9.4
Message-ID: <20010801194006.A210@ping.be>
In-Reply-To: <3B5FC7FB.D5AF0932@zip.com.au> <20010726130809.D17244@emma1.emma.line.org> <3B60022D.C397D80E@zip.com.au> <20010726143002.E17244@emma1.emma.line.org> <9jpea7$s25$1@penguin.transmeta.com> <20010731025700.G28253@emma1.emma.line.org> <20010801170230.B7053@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre2i
In-Reply-To: <20010801170230.B7053@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 01, 2001 at 05:02:30PM +0100, Stephen C. Tweedie wrote:
> Hi,
> 
> > Chase up to the root manually, because Linux' ext2 violates SUS v2
> > fsync() (which requires meta data synched BTW)
> 
> Please quote chapter and verse --- my reading of SUS shows no such
> requirement.  
> 
> fsync is required to force "all currently queued I/O operations
> associated with the file indicated by file descriptor fildes to the
> synchronised I/O completion state."  But as you should know, directory
> entries and files are NOT the same thing in Unix/SUS.  

It goed on with "All I/O operations are completed as defined for
synchronised I/O file integrity completion.", whatever it all
means.

For fdatasync() it says:
"The fdatasync() function forces all currently queued I/O
operations associated with the file indicated by file descriptor
fildes to the synchronised I/O completion state.", which is just
the same as it says for fsync().

It also says:
"The functionality is as described for fsync() (with the symbol
_XOPEN_REALTIME defined), with the exception that all I/O
operations are completed as defined for synchronised I/O data
integrity completion."

It doesn't mention meta-data.

I have no idea what it all means.


Kurt

