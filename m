Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277165AbRKMRRx>; Tue, 13 Nov 2001 12:17:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277282AbRKMRRr>; Tue, 13 Nov 2001 12:17:47 -0500
Received: from pD903CAF1.dip.t-dialin.net ([217.3.202.241]:23261 "EHLO
	no-maam.dyndns.org") by vger.kernel.org with ESMTP
	id <S277165AbRKMRR0>; Tue, 13 Nov 2001 12:17:26 -0500
Date: Tue, 13 Nov 2001 18:16:51 +0100
To: linux-kernel@vger.kernel.org
Subject: Re: linux readahead setting?
Message-ID: <20011113181650.A30354@no-maam.dyndns.org>
In-Reply-To: <Pine.LNX.4.30.0111131619230.1290-100000@mustard.heime.net> <Pine.LNX.4.33L.0111131355030.20809-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L.0111131355030.20809-100000@duckman.distro.conectiva>
User-Agent: Mutt/1.3.23i
From: erik.tews@gmx.net (Erik Tews)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2001 at 01:55:42PM -0200, Rik van Riel wrote:
> On Tue, 13 Nov 2001, Roy Sigurd Karlsbakk wrote:
> 
> > I heard linux does <= 32 page readahead from block devices
> > (scsi/ide/que?). Is there a way to double this? I want to read 256kB
> > chunks from the SCSI drives, as to get the best speed. These numbers are
> > based on some testing and information I've got from Compaq's storage guys.
> 
> The -ac kernels have a way to tune this dynamically,
> I guess we might want to push this change into 2.4
> later on...

I got an other question related to this. I got a System with 7
Filesystems on LVM. One Filesystem contains only one file, a 10 GB
disk-image which is exported via ftp. Sometimes, 15 clients are
downloading the file at the same time. What would be theoretical the
best way to tune these downloads. It would be wise if linux would try to
read the file in big blocks to minimize seeking on the disk. The file is
usually only downloaded in one piece. So if a ftpd-process access the
file, I can be very sure that it will read the whole file. The best
would be if data is requested from the file if linux would read a block
of 256k data from the file before serving the next request from an other
process.
