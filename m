Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130032AbRBSOp6>; Mon, 19 Feb 2001 09:45:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129620AbRBSOpr>; Mon, 19 Feb 2001 09:45:47 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:3894 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S130032AbRBSOpg>; Mon, 19 Feb 2001 09:45:36 -0500
Date: Mon, 19 Feb 2001 08:45:19 -0600 (CST)
From: Jeff Garzik <jgarzik@mandrakesoft.com>
To: Matthew Kirkwood <matthew@hairy.beasts.org>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: sendfile from char device?
In-Reply-To: <Pine.LNX.4.10.10102191356240.11164-100000@sphinx.mythic-beasts.com>
Message-ID: <Pine.LNX.3.96.1010219084411.17842A-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Feb 2001, Matthew Kirkwood wrote:
> I'm looking for a fast way to initialise a file to zeroes
> (without holes) and reckoned that sendfile from /dev/zero
> would be the way to go.
> 
> But, unfortunately, sendfile (in 2.2 and 2.4) appears not
> to support sendfile(2)ing a device:

Correct... sendfile(2) is only for sources/destinations that can be
ripped through the page cache.  I converted Lineo's BusyBox to use
sendfile, only to see it die when used on anything but a normal file or
a socket.

	Jeff




