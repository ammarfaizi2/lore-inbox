Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268123AbTAJDPN>; Thu, 9 Jan 2003 22:15:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268124AbTAJDPN>; Thu, 9 Jan 2003 22:15:13 -0500
Received: from ns.indranet.co.nz ([210.54.239.210]:63427 "EHLO
	mail.acheron.indranet.co.nz") by vger.kernel.org with ESMTP
	id <S268123AbTAJDPM>; Thu, 9 Jan 2003 22:15:12 -0500
Date: Fri, 10 Jan 2003 16:23:31 +1300
From: Andrew McGregor <andrew@indranet.co.nz>
To: Peter Chubb <peter@chubb.wattle.id.au>, eric@andante.org
cc: linux-kernel@vger.kernel.org
Subject: Re: ISO-9660 Rock Ridge gives different links different inums
Message-ID: <1345590000.1042169011@localhost.localdomain>
In-Reply-To: <15902.14667.489252.346007@wombat.chubb.wattle.id.au>
References: <15902.14667.489252.346007@wombat.chubb.wattle.id.au>
X-Mailer: Mulberry/3.0.0b10 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Friday, January 10, 2003 14:08:59 +1100 Peter Chubb 
<peter@chubb.wattle.id.au> wrote:

>
> In linux 2.5.54, multiple links to the same file on a rock-ridge CD
> have different inode numbers.  This confuses cpio, tar and cp -ra
> because the multiple links are each copied separately as a single file.
>
> It'll probably also confuse NFS, but I haven't tried that.

Shouldn't do, but it will probably make the buffer cache on the server less 
effective.

> Currently the inode number appears to be the offset in bytes from the
> start of the file system to the iso directory entry.  Files with multiple
> directory entries (i.e., links) therefore have different inums.
>
> I don't know enough about the ISO9660 standard to be sure what's best
> to do about this.

Change it to be the offset to the data area, which should be the same for 
all of them?

>
> --
> Dr Peter Chubb				    peterc@gelato.unsw.edu.au
> You are lost in a maze of BitKeeper repositories, all almost the same.

