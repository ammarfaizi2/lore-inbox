Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277314AbRJJQre>; Wed, 10 Oct 2001 12:47:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277313AbRJJQrY>; Wed, 10 Oct 2001 12:47:24 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:50328
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S277312AbRJJQrK>; Wed, 10 Oct 2001 12:47:10 -0400
Date: Wed, 10 Oct 2001 12:46:37 -0400
From: Chris Mason <mason@suse.com>
To: "Jeffrey W. Baker" <jwbaker@acm.org>, linux-kernel@vger.kernel.org
Subject: Re: Invalidate: busy buffer at shutdown with 2.4.11
Message-ID: <931490000.1002732397@tiny>
In-Reply-To: <Pine.LNX.4.33.0110100917460.234-100000@desktop>
In-Reply-To: <Pine.LNX.4.33.0110100917460.234-100000@desktop>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wednesday, October 10, 2001 09:18:39 AM -0700 "Jeffrey W. Baker" <jwbaker@acm.org> wrote:

> What does this message mean in 2.4.11 at shutdown time:
> 
> Invalidate: busy buffer
> 
> I'm afraid it means "now your RAID is fucked."

No, it means someone called invalidate_buffers on a device that still
had buffers in use.  This happened with older kernels too, 2.4.11
just complains on the console now.

The in use buffers are left alone, your raid should be fine.

-chris

