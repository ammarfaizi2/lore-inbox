Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318599AbSHPQaB>; Fri, 16 Aug 2002 12:30:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318601AbSHPQaB>; Fri, 16 Aug 2002 12:30:01 -0400
Received: from waste.org ([209.173.204.2]:2776 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S318599AbSHPQaA>;
	Fri, 16 Aug 2002 12:30:00 -0400
Date: Fri, 16 Aug 2002 11:33:49 -0500
From: Oliver Xymoron <oxymoron@waste.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem with random.c and PPC
Message-ID: <20020816163349.GG5418@waste.org>
References: <200208151514.51462.henrique@cyclades.com> <20020815190336.GN22974@opus.bloom.county> <20020815195933.GW9642@clusterfs.com> <20020815210449.GA26993@opus.bloom.county> <ajhlp8$qse$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajhlp8$qse$1@cesium.transmeta.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2002 at 06:50:32PM -0700, H. Peter Anvin wrote:
> Followup to:  <20020815210449.GA26993@opus.bloom.county>
> By author:    Tom Rini <trini@kernel.crashing.org>
> In newsgroup: linux.dev.kernel
> > 
> > Ah, thanks.  In that case, no.  It doesn't look like the input-layer USB
> > keyboards contribute to entropy (but mice do), and I don't think the ADB
> > ones do.  I'll take a crack at adding this to keyboards monday maybe.
> > 
> 
> Be careful... USB devices are *always* going to speak at the same
> place in the USB cycle... I believe that is 1 ms.  Thus,
> submillisecond resolution is *not* random.

Currently not a problem for anyone except X86, as they'll only use HZ
resolution. But the same problem exists on regular mice and keyboards,
which are typically scanned for events at a fixed rate.

This is just the tip of the iceberg for problems with entropy
accounting. I've got some free time today, I'll try to clean up my
patches for this.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
