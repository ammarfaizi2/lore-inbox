Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262329AbREROSZ>; Fri, 18 May 2001 10:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262332AbREROSP>; Fri, 18 May 2001 10:18:15 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:10423 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S262329AbREROSG>; Fri, 18 May 2001 10:18:06 -0400
Date: Fri, 18 May 2001 15:17:50 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Michael Meissner <meissner@spectacle-pond.org>
Cc: Miles Lane <miles@megapathdsl.net>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Stephen Tweedie <sct@redhat.com>
Subject: Re: LANANA: To Pending Device Number Registrants
Message-ID: <20010518151750.A10515@redhat.com>
In-Reply-To: <E504453C04C1D311988D00508B2C5C2DF2F9E1@mail11.gruppocredit.it> <3B0261EC.23BE5EF0@idb.hist.no> <031ypp1oi2.fsf@colargol.tihlde.org> <3B028063.67442F62@idb.hist.no> <990030651.932.3.camel@agate> <20010516121815.B16609@munchkin.spectacle-pond.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010516121815.B16609@munchkin.spectacle-pond.org>; from meissner@spectacle-pond.org on Wed, May 16, 2001 at 12:18:15PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, May 16, 2001 at 12:18:15PM -0400, Michael Meissner wrote:

> With the current LABEL= support, you won't be able to mount the disks with
> duplicate labels, but you can still mount them via /dev/sd<xxx>.

Or you can fall back to mounting by UUID, which is globally unique and
still avoids referencing physical location.  You also don't need to
manually set LABELs for UUID to work: all e2fsprogs over the past
couple of years have set UUID on partitions, and e2fsck will create a
new UUID if it sees an old filesystem that doesn't already have one.

Cheers,
 Stephen
