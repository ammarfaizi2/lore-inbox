Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261868AbREVPdY>; Tue, 22 May 2001 11:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261887AbREVPdE>; Tue, 22 May 2001 11:33:04 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:10763 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261868AbREVPc4>;
	Tue, 22 May 2001 11:32:56 -0400
Date: Tue, 22 May 2001 16:31:35 +0100
From: Matthew Wilcox <matthew@wil.cx>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Matthew Wilcox <matthew@wil.cx>, Linus Torvalds <torvalds@transmeta.com>,
        Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        Alexander Viro <viro@math.psu.edu>, Pavel Machek <pavel@suse.cz>,
        Richard Gooch <rgooch@ras.ucalgary.ca>,
        Andrew Clausen <clausen@gnu.org>, Ben LaHaise <bcrl@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code
Message-ID: <20010522163135.N23718@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20010522021815.M23718@parcelfarce.linux.theplanet.co.uk> <E1526ue-0001WY-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E1526ue-0001WY-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Tue, May 22, 2001 at 08:49:04AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 22, 2001 at 08:49:04AM +0100, Alan Cox wrote:
> > For _devices_, though?  I don't expect my mouse to work if gpm and xfree
> > both try to consume device events from the same filp.  Heck, it doesn't
> > even work when they try to consume events from the same inode :-)  I think
> > this is a reasonable restriction for the class of devices in question.
> 
> Not really. Think about basic things like full duplex audio with two threads

`the class of devices in question' was cryptographic devices, and possibly
other transactional DSPs.  I don't consider audio to be transactional.
in any case, you can do transactional things with two threads, as long
as they each have their own fd on the device.  Think of the fd as your
transaction handle.

-- 
Revolutions do not require corporate support.
