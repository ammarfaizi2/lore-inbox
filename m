Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129413AbRAYJHN>; Thu, 25 Jan 2001 04:07:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129444AbRAYJHC>; Thu, 25 Jan 2001 04:07:02 -0500
Received: from orange.csi.cam.ac.uk ([131.111.8.77]:4046 "EHLO
	orange.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S129413AbRAYJGs>; Thu, 25 Jan 2001 04:06:48 -0500
Date: Thu, 25 Jan 2001 09:06:33 +0000 (GMT)
From: James Sutherland <jas88@cam.ac.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Sasi Peter <sape@iq.rulez.org>, linux-kernel@vger.kernel.org
Subject: Re: Is sendfile all that sexy?
In-Reply-To: <E14LawQ-000893-00@the-village.bc.nu>
Message-ID: <Pine.SOL.4.21.0101250905140.15936-100000@orange.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Jan 2001, Alan Cox wrote:

> > I think, that is not what we need. Once Ingo wrote, that since HTTP 
> > serving can also be viewed as a kind of fileserving, it should be 
> > possible to create a TUX like module for the same framwork, that serves 
> > using the SMB protocol instead of HTTP...
> 
> 
> Kernel SMB is basically not a sane idea. sendfile can help it though

Right now, ISTR Samba is still a forking daemon?? This has less impact on
performance than it would for an httpd, because of the long-lived
sessions, but rewriting it as a state machine (no forking, threads or
other crap, just use non-blocking I/O) would probably make much more
sense.


James.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
