Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135314AbRDWPYD>; Mon, 23 Apr 2001 11:24:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135296AbRDWPXn>; Mon, 23 Apr 2001 11:23:43 -0400
Received: from asterix.hrz.tu-chemnitz.de ([134.109.132.84]:43137 "EHLO
	asterix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S135293AbRDWPXh>; Mon, 23 Apr 2001 11:23:37 -0400
Date: Mon, 23 Apr 2001 17:23:35 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Christoph Rohland <cr@sap.com>
Cc: "David L. Parsley" <parsley@linuxjedi.org>, linux-kernel@vger.kernel.org,
        viro@math.psu.edu
Subject: Re: hundreds of mount --bind mountpoints?
Message-ID: <20010423172335.G719@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <3AE307AD.821AB47C@linuxjedi.org> <m3r8yjrgdc.fsf@linux.local> <20010423151753.C719@nightmaster.csn.tu-chemnitz.de> <m3d7a3r7jp.fsf@linux.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <m3d7a3r7jp.fsf@linux.local>; from cr@sap.com on Mon, Apr 23, 2001 at 04:54:02PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

On Mon, Apr 23, 2001 at 04:54:02PM +0200, Christoph Rohland wrote:
> > The question is: How? If you do it like ramfs, you cannot swap
> > these symlinks and this is effectively a mlock(symlink) operation
> > allowed for normal users. -> BAD!
> 
> How about storing it into the inode structure if it fits into the
> fs-private union? If it is too big we allocate the page as we do it
> now. The union has 192 bytes. This should be sufficient for most
> cases.

Great idea. We allocate this space anyway. And we don't have to
care about the internals of this union, because never have to use
it outside the kernel ;-)

I like it. ext2fs does the same, so there should be no VFS
hassles involved. Al?

Regards

Ingo Oeser
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<     been there and had much fun   >>>>>>>>>>>>
