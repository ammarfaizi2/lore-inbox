Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267447AbUIATtk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267447AbUIATtk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 15:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267474AbUIATrq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 15:47:46 -0400
Received: from nysv.org ([213.157.66.145]:44939 "EHLO nysv.org")
	by vger.kernel.org with ESMTP id S267447AbUIATo4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 15:44:56 -0400
Date: Wed, 1 Sep 2004 22:44:45 +0300
To: Linus Torvalds <torvalds@osdl.org>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>, Pavel Machek <pavel@ucw.cz>,
       David Masover <ninja@slaphack.com>, Jamie Lokier <jamie@shareable.org>,
       Chris Wedgwood <cw@f00f.org>, viro@parcelfarce.linux.theplanet.co.uk,
       Christoph Hellwig <hch@lst.de>, Hans Reiser <reiser@namesys.com>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040901194445.GM26192@nysv.org>
References: <200408311931.i7VJV8kt028102@laptop11.inf.utfsm.cl> <Pine.LNX.4.58.0408311252150.2295@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408311252150.2295@ppc970.osdl.org>
User-Agent: Mutt/1.5.6i
From: mjt@nysv.org (Markus  =?ISO-8859-1?Q?=20T=F6rnqvist?=)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2004 at 01:05:40PM -0700, Linus Torvalds wrote:
>
>There's no point to having the kernel export information that is already 
>inherent in the main stream.

As said before, it can be bounced :)

You have support for streams, someone could read the inherent information
and write it to the stream. At the risk of these two streams being
unsynced temporarily, requiring some syncer.

>I've seen all these examples of exposing MP3 ID information as a "side 
>stream", and that's TOTALLY POINTLESS! The information is already there, 

No it's not pointless :)

>it's in a standard format, and exporting it as a stream buys you 
>absolutely nothing.

There is no nice standard way of finding MP3s by the ID information.

find music/ -name *mp3/..metas/id3/ | xargs grep -i "dream theater"

or something. Which reveals the metadata to find. 
The kernel doesn't have to parse the ID3 tags, that can be handled in 
userspace by a daemon, updated based on mtimes or somesuch, yes?

>Which means that normally we really don't _want_ named streams. In 99% of
>all cases we can use equally good - and _much_ simpler - tool-based
>solutions.

Sure, when someone goes through every application from ls to nautilus
and rams a tool-based patch down the app maintainer's throat and then
we're still dependent on the filesystem layout, which is easier to break
than the filesystem itself :)

>Which means that the only _real_ technical issue for supporting named
>streams really ends up being things like samba, which want named streams

So they should be implemented for samba and other guys can come up with
alternative means for using them ;)

-- 
mjt

