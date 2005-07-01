Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263381AbVGAQfi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263381AbVGAQfi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 12:35:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263384AbVGAQfi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 12:35:38 -0400
Received: from mail.metronet.co.uk ([213.162.97.75]:35496 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S263381AbVGAQfZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 12:35:25 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: "Al Boldi" <a1426z@gawab.com>
Subject: Re: XFS corruption during power-blackout
Date: Fri, 1 Jul 2005 17:35:30 +0100
User-Agent: KMail/1.8.1
Cc: "'Jens Axboe'" <axboe@suse.de>, "'David Masover'" <ninja@slaphack.com>,
       "'Chris Wedgwood'" <cw@f00f.org>, "'Nathan Scott'" <nathans@sgi.com>,
       linux-xfs@oss.sgi.com, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, reiserfs-list@namesys.com
References: <200507011405.RAA27425@raad.intranet>
In-Reply-To: <200507011405.RAA27425@raad.intranet>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507011735.30229.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 01 Jul 2005 15:05, Al Boldi wrote:
> Jens Axboe wrote: {
>
> On Fri, Jul 01 2005, David Masover wrote:
> > Chris Wedgwood wrote:
> > >On Wed, Jun 29, 2005 at 07:53:09AM +0300, Al Boldi wrote:
> > >>What I found were 4 things in the dest dir:
> > >>1. Missing Dirs,Files. That's OK.
> > >>2. Files of size 0. That's acceptable.
> > >>3. Corrupted Files. That's unacceptable.
> > >>4. Corrupted Files with original fingerprint. That's ABSOLUTELY
> > >>unacceptable.
> > >
> > >disk usually default to caching these days and can lose data as a
> > >result, disable that
> >
> > Not always possible.  Some disks lie and leave caching on anyway.
>
> And the same (and others) disks will not honor a flush anyways.
> Moral of that story - avoid bad hardware.
> }
>
> 1. Sync is not the issue. The issue is whether a journaled FS can detect
> corrupted files and flag them after a power-blackout!
> 2. Moral of the story is: What's ext3 doing the others aren't?
>

I agree, I've used XFS for about three years on Linux now, and whilst I love 
the performance and self-repair attributes of the filesystem, I do think it 
leaves a lot to be desired when it comes to file corruption.

In my experience, using a standard XFS log/volume setup on the same physical, 
cheap IDE HD, any files open at the time as a power down or hardware lockup 
end up being filled either with zeros, or garbage.

However, I'd far rather lose a few files once in a blue moon than have to sit 
through 10 minute fsck's every time the kernel crashes or I kick out the 
plugs.

-- 
Cheers,
Alistair.

personal:   alistair()devzero!co!uk
university: s0348365()sms!ed!ac!uk
student:    CS/CSim Undergraduate
contact:    1F2 55 South Clerk Street,
            Edinburgh. EH8 9PP.
