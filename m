Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317541AbSHUAY0>; Tue, 20 Aug 2002 20:24:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317597AbSHUAY0>; Tue, 20 Aug 2002 20:24:26 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:22801 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317541AbSHUAYZ>; Tue, 20 Aug 2002 20:24:25 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: mdelay causes BUG, please use udelay
Date: 20 Aug 2002 17:28:21 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <ajumr5$36s$1@cesium.transmeta.com>
References: <288F9BF66CD9D5118DF400508B68C4460283E4AF@orsmsx113.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <288F9BF66CD9D5118DF400508B68C4460283E4AF@orsmsx113.jf.intel.com>
By author:    "Feldman, Scott" <scott.feldman@intel.com>
In newsgroup: linux.dev.kernel
> 
> > -    msec_delay(10);
> > +    usec_delay(10000);
> 
> Jeff, 10000 seems on the border of what's OK.  If it's acceptable, then
> let's go for that.  Otherwise, we're going to have to chain several
> mod_timer callbacks together to do a controller reset.
> 

10 ms in an interrupt context?  Surely you're joking...

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
