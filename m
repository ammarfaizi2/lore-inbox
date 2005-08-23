Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932100AbVHWJIV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932100AbVHWJIV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 05:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932101AbVHWJIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 05:08:21 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:51869 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S932100AbVHWJIU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 05:08:20 -0400
Date: Tue, 23 Aug 2005 11:07:59 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org,
       jffs-dev@axis.com
Subject: Re: use of uninitialized pointer in jffs_create()
Message-ID: <20050823090759.GB27570@wohnheim.fh-wedel.de>
References: <9a87484905082015284c1686ec@mail.gmail.com> <20050822104559.GA11876@wohnheim.fh-wedel.de> <20050822230758.GL9927@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050822230758.GL9927@stusta.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 August 2005 01:07:58 +0200, Adrian Bunk wrote:
> On Mon, Aug 22, 2005 at 12:45:59PM +0200, Jörn Engel wrote:
> > On Sun, 21 August 2005 00:28:08 +0200, Jesper Juhl wrote:
> > > 
> > > gcc kindly pointed me at jffs_create() with this warning : 
> > > 
> > > fs/jffs/inode-v23.c:1279: warning: `inode' might be used uninitialized
> > > in this function
> > 
> > Real fix would be to finally remove that code.  Except for the usual
> > "change this function in the whole kernel" stuff, noone has touched it
> > for ages.
> 
> That's wrong, this -mm specific bug comes git-ocfs2.patch .

Ack.  If I wasn't this lazy, I'd still propose to completely remove
jffs - it's been old and deprecated for a few years already.

Jörn

-- 
Public Domain  - Free as in Beer
General Public - Free as in Speech
BSD License    - Free as in Enterprise
Shared Source  - Free as in "Work will make you..."
