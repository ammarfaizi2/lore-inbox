Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262022AbRESXcH>; Sat, 19 May 2001 19:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261999AbRESXb6>; Sat, 19 May 2001 19:31:58 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:37548 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S262004AbRESXbk>;
	Sat, 19 May 2001 19:31:40 -0400
Message-ID: <3B070257.5632A059@mandrakesoft.com>
Date: Sat, 19 May 2001 19:31:35 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>, Ben LaHaise <bcrl@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: Why side-effects on open(2) are evil. (was Re: [RFD 
 w/info-PATCH]device arguments from lookup)
In-Reply-To: <Pine.GSO.4.21.0105191904490.7162-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Are we talking about device arguments just for chrdevs and blkdevs? 
(ie. drivers)  or for regular files too?

Speaking about drivers specifically, a controlling miscdev, one per
device or one per group of devices depending on your needs, is a much
more clean solution for passing ioctl-type data.  You are free to come
up with whatever method of communication with the driver is most
efficient for your needs -- without perverting open(2).

Notice also a "metadata miscdev" solves the problem of passing options
on open -- just pass those options to the miscdev before you open it...

metadata miscdevs are a clean solution to what procfs hacks and ioctls
are trying to accomplish.

	Jeff


-- 
Jeff Garzik      | "Do you have to make light of everything?!"
Building 1024    | "I'm extremely serious about nailing your
MandrakeSoft     |  step-daughter, but other than that, yes."
