Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270132AbRIECBl>; Tue, 4 Sep 2001 22:01:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270134AbRIECBa>; Tue, 4 Sep 2001 22:01:30 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:61063
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S270132AbRIECBZ>; Tue, 4 Sep 2001 22:01:25 -0400
Date: Tue, 04 Sep 2001 22:01:37 -0400
From: Chris Mason <mason@suse.com>
To: Hans Reiser <reiser@namesys.com>
cc: Pavel Machek <pavel@suse.cz>, Nikita Danilov <Nikita@namesys.com>,
        Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
        reiserfs-dev@namesys.com
Subject: Re: Reiserfs: how to mount without journal replay?
Message-ID: <465880000.999655297@tiny>
In-Reply-To: <3B9548BF.CB0DE452@namesys.com>
In-Reply-To: <20010826130858.A39@toy.ucw.cz>
 <15246.11218.125243.775849@gargle.gargle.HOWL>
 <20010830225323.A18630@atrey.karlin.mff.cuni.cz>
 <3B8EAD35.5695B30B@namesys.com> <20010830235005.B9330@bug.ucw.cz>
 <417980000.999636835@tiny> <3B9548BF.CB0DE452@namesys.com>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wednesday, September 05, 2001 01:33:51 AM +0400 Hans Reiser
<reiser@namesys.com> wrote:

> I hate to ask you this, but will the result be a stream of users mounting
> -noreplay, and then asking us why things are broken (or worse, not
> asking....).


Well, now that we have the patch, fine tuning the user experience is easy.
It depends on the demand for the feature....

In my mind, the most important part is that it does not allow a read/write
mount when there are transactions that need to be replayed, so they can't
screw up their FS any worse than it was before they started ;-)

-chris

