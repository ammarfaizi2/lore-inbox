Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261497AbREVBUA>; Mon, 21 May 2001 21:20:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261503AbREVBTk>; Mon, 21 May 2001 21:19:40 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7177 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261427AbREVBTi>;
	Mon, 21 May 2001 21:19:38 -0400
Date: Tue, 22 May 2001 02:18:15 +0100
From: Matthew Wilcox <matthew@wil.cx>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Matthew Wilcox <matthew@wil.cx>,
        Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        Alexander Viro <viro@math.psu.edu>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Pavel Machek <pavel@suse.cz>,
        Richard Gooch <rgooch@ras.ucalgary.ca>,
        Andrew Clausen <clausen@gnu.org>, Ben LaHaise <bcrl@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code
Message-ID: <20010522021815.M23718@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20010522015714.K23718@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.31.0105211812510.17857-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.31.0105211812510.17857-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Mon, May 21, 2001 at 06:13:18PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2001 at 06:13:18PM -0700, Linus Torvalds wrote:
> Nope. You can (and people do, quite often) share filps. So you can't
> associate state with it.

For _devices_, though?  I don't expect my mouse to work if gpm and xfree
both try to consume device events from the same filp.  Heck, it doesn't
even work when they try to consume events from the same inode :-)  I think
this is a reasonable restriction for the class of devices in question.

-- 
Revolutions do not require corporate support.
