Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276453AbRJCQRb>; Wed, 3 Oct 2001 12:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276452AbRJCQRW>; Wed, 3 Oct 2001 12:17:22 -0400
Received: from chunnel.redhat.com ([199.183.24.220]:52218 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S276451AbRJCQRP>; Wed, 3 Oct 2001 12:17:15 -0400
Date: Wed, 3 Oct 2001 17:17:03 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Hans Reiser <reiser@namesys.com>
Cc: foner-reiserfs@media.mit.edu, linux-kernel@vger.kernel.org,
        Stephen Tweedie <sct@redhat.com>
Subject: Re: ReiserFS data corruption in very simple configuration
Message-ID: <20011003171703.B5209@redhat.com>
In-Reply-To: <200109221000.GAA11263@out-of-band.media.mit.edu> <3BB88B63.AEE6EF8E@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BB88B63.AEE6EF8E@namesys.com>; from reiser@namesys.com on Mon, Oct 01, 2001 at 07:27:31PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Oct 01, 2001 at 07:27:31PM +0400, Hans Reiser wrote:
> This is the meaning of metadata journaling: that writes in progress at the time
> of the crash may write garbage, but you won't need to fsck.  You can get this
> behaviour with other filesystems like FFS also.  If you cannot accept those
> terms of service, you might use ext3 with data journaling on, but then your
> performance will be far worse.

ext3 with ordered data writes has performance nearly up to the level
of the fast-and-loose writeback mode for most workloads, and still
avoids ever exposing stale disk blocks after a crash.

Sure, it's a tradeoff, but there are positions between the two
extremes (totally unordered data writes, and totally journaled data
writes) which offer a good compromise here.

Cheers,
 Stephen
