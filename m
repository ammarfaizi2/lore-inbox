Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136701AbREJOx1>; Thu, 10 May 2001 10:53:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136703AbREJOxS>; Thu, 10 May 2001 10:53:18 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:64273
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S136701AbREJOw6>; Thu, 10 May 2001 10:52:58 -0400
Date: Thu, 10 May 2001 10:51:12 -0400
From: Chris Mason <mason@suse.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Andrew Morton <andrewm@uow.edu.au>
cc: Linus Torvalds <torvalds@transmeta.com>,
        "David S. Miller" <davem@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] writepage method changes
Message-ID: <1537180000.989506272@tiny>
In-Reply-To: <Pine.LNX.4.21.0105092245470.16087-100000@freak.distro.conectiva>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wednesday, May 09, 2001 10:51:17 PM -0300 Marcelo Tosatti
<marcelo@conectiva.com.br> wrote:

> 
> 
> On Wed, 9 May 2001, Marcelo Tosatti wrote:
> 
>> Locked for the "not wrote out case" (I will fix my patch now, thanks)
> 
> I just found out that there are filesystems (eg reiserfs) which write out
> data even if an error ocurred, which means the unlocking must be done by
> the filesystems, always. 

I'm not horribly attached to the way reiserfs is doing it right now.  If
reiserfs writepage manages to map any blocks, it writes them to disk, even
if mapping other blocks in the page failed.  These are only data blocks, so
there are no special consistency rules.  If we need to change this, it is
not a big deal.

-chris


