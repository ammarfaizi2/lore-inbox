Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286858AbRLWJxh>; Sun, 23 Dec 2001 04:53:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286856AbRLWJx2>; Sun, 23 Dec 2001 04:53:28 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:14085 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S286861AbRLWJxQ>; Sun, 23 Dec 2001 04:53:16 -0500
Message-ID: <3C25A981.1090803@zytor.com>
Date: Sun, 23 Dec 2001 01:53:05 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Ryan Cumming <bodnar42@phalynx.dhs.org>
CC: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: tar vs cpio (was: Booting a modular kernel through a multiple streams file)
In-Reply-To: <Pine.GSO.4.21.0112222109050.21702-100000@weyl.math.psu.edu> <3C25A06D.7030408@zytor.com> <E16I5Hz-0001ZJ-00@phalynx>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ryan Cumming wrote:

> 
> What about recycling a big-endian version of cramfs? IIRC, the format is 
> really clean, it already does compression, and is terse enough to be efficent 
> for booting purposes. However, it might be too terse as it:
> 1) Doesn't support hard links
> 2) Doesn't store atime/mtime/ctime
> 
> I don't know if that'd be too restrictive for an initrd replacement, but 
> having only one compressed-filesystemish filesystem for the kernel would be 
> nice.
> 


You don't want to use the cramfs format.  It does a lot of things wrong 
for this application (such as block compression.)

	-hpa



