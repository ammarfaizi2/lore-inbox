Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265863AbSLCUvE>; Tue, 3 Dec 2002 15:51:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265865AbSLCUvE>; Tue, 3 Dec 2002 15:51:04 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:36101 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S265863AbSLCUvC>; Tue, 3 Dec 2002 15:51:02 -0500
Date: Tue, 3 Dec 2002 20:58:30 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Austin Gonyou <austin@coremetrics.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-aa1 questions.
Message-ID: <20021203205830.A25661@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Austin Gonyou <austin@coremetrics.com>,
	linux-kernel@vger.kernel.org
References: <1038948847.1772.7.camel@UberGeek>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1038948847.1772.7.camel@UberGeek>; from austin@coremetrics.com on Tue, Dec 03, 2002 at 02:54:08PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 03, 2002 at 02:54:08PM -0600, Austin Gonyou wrote:
> what do the following patches actually *fix*?
> 
> 00_backout-gcc-3_0-patch-1
> 00_gcc-30-volatile-xtime-1
> 
> I'm trying to get 2.4.20 patched up by using the -aa split patches for
> 2.4.20 and I'm incorporating only the things I want, but I use gcc 3.2
> for compiling, and these confused me a bit.

Oooh,  I had lengthy discussion with andrea on those two.  These patches
are a) grossly misnamed and b) should be one.  They change xtime to a volatile
because andrea thinks that's safer.

The background on the silly naming is that earlier 2.4 kernels had xtime
not volatile but the prototype (or vice versa) and gcc3 didn't like that.

So the best idea would be to merge them into 00_xtime_volatile-1 if
you want to keep them.
