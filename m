Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267758AbTAaKrX>; Fri, 31 Jan 2003 05:47:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267761AbTAaKrW>; Fri, 31 Jan 2003 05:47:22 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:39687 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267758AbTAaKrW>; Fri, 31 Jan 2003 05:47:22 -0500
Date: Fri, 31 Jan 2003 10:56:43 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21pre4aa1
Message-ID: <20030131105643.B18876@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
References: <20030131014020.GA8395@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030131014020.GA8395@dualathlon.random>; from andrea@suse.de on Fri, Jan 31, 2003 at 02:40:20AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2003 at 02:40:20AM +0100, Andrea Arcangeli wrote:
> Only in 2.4.21pre3aa1: 00_getcwd-err-1
> Only in 2.4.21pre4aa1: 00_getcwd-err-2
> 
> 	Part of it merged in mainline.

A different, cleaner version has been merged in mainline.  00_getcwd-err-2
just adds unreachable code.

> Only in 2.4.21pre4aa1: 9996_kiobuf-slab-1
> 
> 	Keep the kiobuf + bhs cache in the slab rather than in the file
> 	structure, so it scales also while sharing the same file from two
> 	different filedescriptors at the same time (like with threads or
> 	after forks). From Jun Nakajima.

The patch is ugly as hell.  I'll dig up the patch I did with similar
functionality but a much nicer style and a sysctl-controllable cut-off
point for keeping the bhs around in the constructed kiobuf objects.

> 
