Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275084AbTHLHLQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 03:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275092AbTHLHLQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 03:11:16 -0400
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73]:32988
	"EHLO michonline.com") by vger.kernel.org with ESMTP
	id S275084AbTHLHLN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 03:11:13 -0400
Date: Tue, 12 Aug 2003 03:11:12 -0400
From: Ryan Anderson <ryan@michonline.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [Dri-devel] Re: [PATCH] CodingStyle fixes for drm_agpsupport
Message-ID: <20030812071112.GQ24278@michonline.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <A98078D7EF5BEA4D8D8FD797FFBBC75F0453FCEA@fmsmsx402.fm.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A98078D7EF5BEA4D8D8FD797FFBBC75F0453FCEA@fmsmsx402.fm.intel.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 11, 2003 at 01:21:22PM -0700, Sottek, Matthew J wrote:


> 2) There are some very real ways that bracketless code will
> get broken. Either someone adds a line that didn't notice the
> lack of brackets or, someone accidentally uses a multi-line
> macro.
> 
> i.e.
>    if(foo)
>      DEBUG_PRINT("Foo!\n");
> 
> works great for 100 years until someone recodes the DEBUG_PRINT
> macro to be 2 lines. The Linux kernel often has plain looking
> functions or variables that end up being macros (and may only
> expand to multi-line on some platforms) which could easily get
> you into such a situation.

#define DEBUG_PRINT(x) do { printk((x)); printk((x)); } while (0)

I believe your example is, oh, the #1 reason for this style of macro.

-- 

Ryan Anderson
  sometimes Pug Majere
