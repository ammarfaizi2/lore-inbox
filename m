Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261572AbREOVaj>; Tue, 15 May 2001 17:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261559AbREOVaV>; Tue, 15 May 2001 17:30:21 -0400
Received: from shed.alex.org.uk ([195.224.53.219]:58256 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S261565AbREOV3n>;
	Tue, 15 May 2001 17:29:43 -0400
Date: Tue, 15 May 2001 22:29:38 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>,
        Jonathan Lundell <jlundell@pobox.com>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        James Simmons <jsimmons@transvirtual.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        viro@math.psu.edu,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: LANANA: To Pending Device Number Registrants
Message-ID: <344250272.989965778@[169.254.198.40]>
In-Reply-To: <Pine.LNX.4.21.0105151309460.2470-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.21.0105151309460.2470-100000@penguin.transmeta.com>
X-Mailer: Mulberry/2.1.0a4 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The argument that "if you use numbering based on where in the SCSI chain
> the disk is, disks don't pop in and out" is absolute crap. It's not true
> even for SCSI any more (there are devices that will aquire their location
> dynamically), and it has never been true anywhere else. Give it up.

Q: Let us assume you have dynamic numbering disk0..N as you suggest,
   and you have some s/w RAID of SCSI disks. A disk fails, and is (hot)
   removed. Life continues. You reboot the machine. Disks are now numbered
   disk0..(N-1). If the RAID config specifies using disk0..N thusly, it
   is going to be very confused, as stripes will appear in the wrong place.
   Doesn't that mean the file specifying the RAID config is going to have
   to enumerate SCSI IDs (or something configuration invariant) as
   opposed to use the disk0..N numbering anyway? Sure it can interrogate
   each disk0..N to see which has the ID that it actually wanted, but
   doesn't this rather subvert the purpose?

IE, given one could create /dev/disk/?.+, isn't the important
argument that they share common major device numbers etc., not whether
they linearly reorder precisely to 0..N as opposed to have some form
of identifier guaranteed to be static across reboot & config change.
--
Alex Bligh
