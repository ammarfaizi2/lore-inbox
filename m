Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315258AbSEIX7H>; Thu, 9 May 2002 19:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315260AbSEIX7G>; Thu, 9 May 2002 19:59:06 -0400
Received: from imladris.infradead.org ([194.205.184.45]:61195 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S315258AbSEIX7F>; Thu, 9 May 2002 19:59:05 -0400
Date: Fri, 10 May 2002 00:58:52 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Hanna Linder <hannal@us.ibm.com>
Cc: alan@lxorguk.ukuu.org.uk, viro@math.psu.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.4.19-pre8] FastWalk Dcache back port from 2.5
Message-ID: <20020510005851.B21332@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Hanna Linder <hannal@us.ibm.com>, alan@lxorguk.ukuu.org.uk,
	viro@math.psu.edu, linux-kernel@vger.kernel.org
In-Reply-To: <16290000.1020988333@w-hlinder.des>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 09, 2002 at 04:52:13PM -0700, Hanna Linder wrote:
> Hello,
> 
> 	Please consider this new and improved fast walk patch for
> inclusion in your 2.4.19 tree. This patch reduces cacheline bouncing 
> due to numerous atomic increments and decrements of the d_count 
> reference counter during path walking by holding the dcache_lock
> as long as the dentries are in the cache. 
> 	Linus included my original patch in 2.5.11. Al Viro made a 
> few great changes in 2.5.12 and Paul Menage added one fix. The following
> patch includes their changes as well. This code has been in 2.5 for 
> almost 3 weeks and appears to be quite stable.

The fixed code isn't there for a long time yet..  I'd rather see the
path_lookup cleanup which already is in -ac go into 2.4.19 (and if I
understood Marcelo right that'll be release in the next time) and wait
for 2.4.20-pre<early> for the massive changes.

Just my .5 (Euro-)Cent.
