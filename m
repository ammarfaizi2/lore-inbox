Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289351AbSAJHNZ>; Thu, 10 Jan 2002 02:13:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289353AbSAJHNO>; Thu, 10 Jan 2002 02:13:14 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:65290 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S289351AbSAJHNA>;
	Thu, 10 Jan 2002 02:13:00 -0500
Date: Thu, 10 Jan 2002 08:12:52 +0100
From: Jens Axboe <axboe@suse.de>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Badari Pulavarty <pbadari@us.ibm.com>, linux-kernel@vger.kernel.org,
        marcelo@conectiva.com.br, andrea@suse.de
Subject: Re: [PATCH] PAGE_SIZE IO for RAW (RAW VARY)
Message-ID: <20020110081252.P19814@suse.de>
In-Reply-To: <20020109125845.B12609@redhat.com> <200201091812.g09ICBF18477@eng2.beaverton.ibm.com> <20020109132148.C12609@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020109132148.C12609@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09 2002, Benjamin LaHaise wrote:
> On Wed, Jan 09, 2002 at 10:12:11AM -0800, Badari Pulavarty wrote:
> > why ? could you explain ? I am not expecting that user buffer be aligned
> > to PAGE_SIZE.
> 
> Okay, that part I misread from the message, but that leaves the question of 
> "does it work?"  Iirc, Jeff Merkey tested variable sized ios with nwfs, but 
> found that triggered bugs in the low level drivers, some of which assume that 
> all buffer heads within a request have the same block size.  Given that 
> concern, I really don't think this is a safe 2.4 patch.

I don't think that point was ever proven, and Jeff never showed any
information as to what was broken. I'm reluctant to allow differently
sized buffers heads in the _same_ request for 2.4 just to be cautios,
but that's a two-liner (or so) in the elevator to stop that from
happening.

-- 
Jens Axboe

