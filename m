Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275012AbRKFFX1>; Tue, 6 Nov 2001 00:23:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275265AbRKFFXT>; Tue, 6 Nov 2001 00:23:19 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:27324 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S277143AbRKFFV5>; Tue, 6 Nov 2001 00:21:57 -0500
Date: Mon, 5 Nov 2001 22:21:52 -0700
Message-Id: <200111060521.fA65LqQ19285@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: more devfs fun (Piled Higher and Deeper)
In-Reply-To: <Pine.GSO.4.21.0110271536190.21545-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0110271513580.21545-100000@weyl.math.psu.edu>
	<Pine.GSO.4.21.0110271536190.21545-100000@weyl.math.psu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro writes:
> devfs_rmdir() checks that directory is empty.  Then it calls
> devfsd_notify_one(), which can block.  Then it marks the entry
> unregistered and reports success.
> 
> Guess what will happen if devfs_register() will happen at that
> moment...

Yeah, I fixed that one a couple of months ago in the new tree. I now
unhook from the directory structure before sending the notification.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
