Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261587AbSJQAvo>; Wed, 16 Oct 2002 20:51:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261590AbSJQAvo>; Wed, 16 Oct 2002 20:51:44 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:22539 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S261587AbSJQAvn>; Wed, 16 Oct 2002 20:51:43 -0400
Date: Thu, 17 Oct 2002 01:57:28 +0100
From: John Levon <levon@movementarian.org>
To: "David S. Miller" <davem@redhat.com>
Cc: weigand@immd1.informatik.uni-erlangen.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [8/7] oprofile - dcookies need to use u32
Message-ID: <20021017005728.GA8267@compsoc.man.ac.uk>
References: <200210160156.DAA25005@faui11.informatik.uni-erlangen.de> <20021015.190019.41374479.davem@redhat.com> <20021016164057.GB85246@compsoc.man.ac.uk> <20021016.143843.99745166.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021016.143843.99745166.davem@redhat.com>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan *181yye-000Pro-00*giYBAGckR.U* (Manchester Computing, University of Manchester)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2002 at 02:38:43PM -0700, David S. Miller wrote:

> I don't understand why using a bigger type is not an option.
> 
> Why not just use u64?  That would work too.

The oprofile event buffer is unsigned long [], and stores cookie values.
Surely that would require us to use u64 there too, doubling the buffer
sizes on 32-bit machines ?

I suppose we could do so magic to spread the cookie value across two
buffer entries if necessary, but that's ugly...

regards
john

-- 
"It's a cardboard universe ... and if you lean too hard against it, you fall
 through." 
	- Philip K. Dick 
