Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261821AbSJIPTj>; Wed, 9 Oct 2002 11:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261818AbSJIPTj>; Wed, 9 Oct 2002 11:19:39 -0400
Received: from pc-62-31-74-104-ed.blueyonder.co.uk ([62.31.74.104]:19843 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S261813AbSJIPTi>; Wed, 9 Oct 2002 11:19:38 -0400
Date: Wed, 9 Oct 2002 16:25:13 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Andreas Gruenbacher <agruen@suse.de>
Cc: "Theodore Ts'o" <tytso@mit.edu>, "Stephen C. Tweedie" <sct@redhat.com>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] [RFC] [PATCH 3/4] Add extended attributes to ext2/3
Message-ID: <20021009162513.F2779@redhat.com>
References: <E17yymK-00021n-00@think.thunk.org> <20021008214143.O2717@redhat.com> <20021008221710.GA9842@think.thunk.org> <200210091329.28153.agruen@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200210091329.28153.agruen@suse.de>; from agruen@suse.de on Wed, Oct 09, 2002 at 01:29:28PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Oct 09, 2002 at 01:29:28PM +0200, Andreas Gruenbacher wrote:
> On Wednesday 09 October 2002 00:17, Theodore Ts'o wrote:
> > Well, how about this as a compromise?  We define a new superblock
> > field which reserves a certain amount of space in the EA block for
> > "system" attributes. 

> > Andreas, does that sound good to you?
> 
> I'd rather not store such policy things on the file system permanently, and 
> make it a mount option. I'm wondering how many installations this would 
> affect; to me it seems that it's not worth a super block flag.

We already have a lot of similar places where we do this in ext2/3.
The standard procedure is to store the default in the superblock but
to allow the user to override at mount time.

--Stephen
