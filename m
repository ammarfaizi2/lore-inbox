Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263734AbTIBUPU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 16:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263772AbTIBUPU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 16:15:20 -0400
Received: from [213.39.233.138] ([213.39.233.138]:6570 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S263734AbTIBUPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 16:15:15 -0400
Date: Tue, 2 Sep 2003 22:11:50 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Dave Olien <dmo@osdl.org>
Cc: Petri Koistinen <petri.koistinen@iki.fi>, linux-kernel@vger.kernel.org
Subject: Re: Sparse warning: bitmap.h: bad constant expression
Message-ID: <20030902201150.GC24744@wohnheim.fh-wedel.de>
References: <Pine.LNX.4.56.0309012249230.14789@dsl-hkigw4a35.dial.inet.fi> <20030902015702.GA10265@osdl.org> <20030902095628.GB7616@wohnheim.fh-wedel.de> <20030902173844.GA20578@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030902173844.GA20578@osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 September 2003 10:38:44 -0700, Dave Olien wrote:
> 
> I was lazy with my problem summary yesterday.  The sparse warning is actually
> about the declaration of the functions bitmap_shift_right() and
> bitmap_shift_left() in bitmap.h.  In these cases, the bits argument to
> DECLARE_BITMAP() was an argument to the function, and th variable sized
> array is in the scope of that function.
> 
> The only uses of these functions I can find are in the macros
> physids_shift_right, physids_shift_left, in mpsec.h, and cpus_shift_rigt
> and cpus_shift_left, in cpumask_array.h.
> 
> In all uses, the "bits" argument eventually resolves to being a constant.
> It would require the inline expansion of the bitmap_shift_*() functions
> to take advantage of that.

If your analysis is correct, this looks safe enough for now.  It would
be nice to replace it with something more explicit, but I just don't
care enough yet.

Jörn

-- 
Fantasy is more important than knowlegde. Knowlegde is limited,
while fantasy embraces the whole world.
-- Albert Einstein
