Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262224AbUDDHFC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 03:05:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262225AbUDDHFC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 03:05:02 -0400
Received: from holomorphy.com ([207.189.100.168]:22714 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262224AbUDDHE7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 03:04:59 -0400
Date: Sat, 3 Apr 2004 23:04:49 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Paul Jackson <pj@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: remove bitmap_shift_*() bitmap length limits
Message-ID: <20040404070449.GZ791@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Paul Jackson <pj@sgi.com>, linux-kernel@vger.kernel.org
References: <20040330065152.GJ791@holomorphy.com> <20040330073604.GK791@holomorphy.com> <20040330081142.GL791@holomorphy.com> <20040401133033.435a3857.pj@sgi.com> <20040401144234.2ef3c205.pj@sgi.com> <20040403225712.7d4acc86.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040403225712.7d4acc86.pj@sgi.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 03, 2004 at 10:57:12PM -0800, Paul Jackson wrote:
> There was one bug in my untested code for simple bitmap shifts,
> the left shift needs to scan downwards, not upwards, so as to
> avoid clobbering the input if shifting inplace.
> The total text size of my user level test program is actually
> made smaller with this per-bit simple implementation, as compared
> to the implementation currently in the kernel, by 80 bytes.
> Bill Irwin's more sophisticated version grows the text size,
> over the current implementation, by 304 bytes.  This is on
> Pentium pc, gcc version 3.3.2, compiled -O2.
> Given the very rare usage this bitmap shift routines receive,
> I cast my vote for small and simple.
> The more sophisticated logic of Bill's implementation is
> impressive, but unjustified in this situation, in my view.
> My fixed shift functions are:

I don't see this as a hard problem or why you call the implementation I
brewed up impressive. I don't personally have a preference as to what
implementation is used so long as it's not got fixed-size arrays in it,
though I am somewhat puzzled as to why you bothered.


-- wli
