Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273929AbRIXPFL>; Mon, 24 Sep 2001 11:05:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273931AbRIXPFB>; Mon, 24 Sep 2001 11:05:01 -0400
Received: from pD957B3C7.dip.t-dialin.net ([217.87.179.199]:1030 "EHLO
	enigma.deepspace.net") by vger.kernel.org with ESMTP
	id <S273929AbRIXPEu>; Mon, 24 Sep 2001 11:04:50 -0400
Message-Id: <200109241505.RAA12224@enigma.deepspace.net>
Content-Type: text/plain; charset=US-ASCII
From: Wolly <wwolly@gmx.net>
To: Chris Mason <mason@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: Huge disk performance degradation STILL IN 2.4.10
Date: Mon, 24 Sep 2001 17:05:13 +0200
X-Mailer: KMail [version 1.2.1]
In-Reply-To: <200109211723.TAA00638@enigma.deepspace.net> <200109232319.BAA02449@enigma.deepspace.net> <2100580000.1001289300@tiny>
In-Reply-To: <2100580000.1001289300@tiny>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 24 September 2001 01:55, Chris Mason wrote:
> On Monday, September 24, 2001 01:19:18 AM +0200 Wolly <wwolly@gmx.net>
> wrote:
> > Hi kernel hackers,
> >
> > As soon as 2.4.10 was out, I got the patch and tested it again.
> > The problem is still there and did not get better at all.
>
> Could you please mount the FS with -o notail and try again?  I think your
> test is hitting a worst case in the 2.4.x reiserfs tail code.
>
Okay, I plugged some old hd into my computer and formatted one half with 
ext2, the other half with reiserfs. 
It seems to be definitely a reiserfs issue because I cannot trigger the 
performance loss (permament hd head positioning) with ext2. However, 
passing -o notail when mounting does not help. (-o notail is accepted and 
`bash# mount' displays `/dev/hdxy on /mnt type reiserfs (rw,notail)')

Could you reproduce this? Did you even try?
And why does this not show up on kernels <=2.4.6 and shows up 
with linux>=2.4.9 (2.4.7, 2.4.8: unknown)?

-Wolly
