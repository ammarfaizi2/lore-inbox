Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261910AbREVPjo>; Tue, 22 May 2001 11:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261892AbREVPje>; Tue, 22 May 2001 11:39:34 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4108 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261889AbREVPj1>;
	Tue, 22 May 2001 11:39:27 -0400
Date: Tue, 22 May 2001 16:38:30 +0100
From: Matthew Wilcox <matthew@wil.cx>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Matthew Wilcox <matthew@wil.cx>, Linus Torvalds <torvalds@transmeta.com>,
        Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        Alexander Viro <viro@math.psu.edu>, Pavel Machek <pavel@suse.cz>,
        Richard Gooch <rgooch@ras.ucalgary.ca>,
        Andrew Clausen <clausen@gnu.org>, Ben LaHaise <bcrl@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code
Message-ID: <20010522163830.O23718@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20010522163135.N23718@parcelfarce.linux.theplanet.co.uk> <E152E8H-00024B-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E152E8H-00024B-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Tue, May 22, 2001 at 04:31:37PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 22, 2001 at 04:31:37PM +0100, Alan Cox wrote:
> > `the class of devices in question' was cryptographic devices, and possibly
> > other transactional DSPs.  I don't consider audio to be transactional.
> > in any case, you can do transactional things with two threads, as long
> > as they each have their own fd on the device.  Think of the fd as your
> > transaction handle.
> 
> Thats a bit pathetic. So I have to fill my app with expensive pthread locks
> or hack all the drivers and totally change the multi-open sematics in the ABI

huh?

void thread_init(void) {
	int fd = open("/dev/crypto");
	real_thread_init(fd);
}

where was that lock again?

and notice this idea is only for transactional things -- what
transactional things do sound drivers do?

-- 
Revolutions do not require corporate support.
