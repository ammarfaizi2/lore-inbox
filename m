Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129736AbQJ1Nxw>; Sat, 28 Oct 2000 09:53:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130570AbQJ1Nxm>; Sat, 28 Oct 2000 09:53:42 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:275 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S129736AbQJ1Nxe>;
	Sat, 28 Oct 2000 09:53:34 -0400
Date: Sat, 28 Oct 2000 14:53:12 +0100
From: Philipp Rumpf <prumpf@parcelfarce.linux.theplanet.co.uk>
To: Brian Gerst <bgerst@didntduck.org>
Cc: Andrew Morton <andrewm@uow.edu.au>,
        Patrick van de Lageweg <patrick@bitwizard.nl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rogier Wolff <wolff@bitwizard.nl>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PROPOSED PATCH] ATM refcount + firestream
Message-ID: <20001028145312.B2272@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <Pine.LNX.4.21.0010270945510.13233-200000@panoramix.bitwizard.nl> <39F96BE1.B9C97C20@uow.edu.au> <20001028141518.A2272@parcelfarce.linux.theplanet.co.uk> <39FAD698.2FF9C8C8@didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <39FAD698.2FF9C8C8@didntduck.org>; from bgerst@didntduck.org on Sat, Oct 28, 2000 at 09:37:28AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 28, 2000 at 09:37:28AM -0400, Brian Gerst wrote:
> Philipp Rumpf wrote:
> >  - you can't copy_(from|to)_user in the module exit function (which would
> > be copies from/to rmmod anyway)
> 
> Unfortunately, you need to be able to use copy_*_user() from the network
> ioctls, and this is the center of the current issue.

You misunderstood.  The network ioctls aren't module_exit functions, so
copy_*_user in them is fine.

	Philipp Rumpf
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
