Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264422AbUEND27@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264422AbUEND27 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 23:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264709AbUEND27
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 23:28:59 -0400
Received: from fw.osdl.org ([65.172.181.6]:29111 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264422AbUEND25 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 23:28:57 -0400
Date: Thu, 13 May 2004 20:26:17 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: benh@kernel.crashing.org, kronos@kronoz.cjb.net,
       linux-kernel@vger.kernel.org
Subject: Re: [4KSTACK][2.6.6] Stack overflow in radeonfb
Message-Id: <20040513202617.3ed4f3c9.rddunlap@osdl.org>
In-Reply-To: <20040513182153.1feb488b.akpm@osdl.org>
References: <20040513145640.GA3430@dreamland.darkstar.lan>
	<1084488901.3021.116.camel@gaston>
	<20040513182153.1feb488b.akpm@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 May 2004 18:21:53 -0700 Andrew Morton <akpm@osdl.org> wrote:

| Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
| >
| >  > 
| >  > int radeonfb_set_par(struct fb_info *info)
| >  > {
| >  >         struct radeonfb_info *rinfo = info->par;
| >  >         struct fb_var_screeninfo *mode = &info->var;
| >  >         struct radeon_regs newmode;
| >  >         
| >  > struct radeon_regs is huge: 2356 bytes
| >  > Quick fix (I'll test ASAP):
| > 
| >  Wow, this is evil indeed,
| 
| There should be some sort of prize ;)
| 
| There's a script out there somewhere which can autodetect this: build with
| frame pointers, parse the function preamble.  Does anyone have a copy
| handly?

Sure, it's at http://www.kernelnewbies.org/scripts/,
look for check-stack.sh, along with some other useful scripts.

| There's a `make buildcheck' target in -mm (from Arjan) into which we could
| integrate such a tool.  Although probably it should be a different make
| target.


--
~Randy
