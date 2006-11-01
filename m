Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946766AbWKAKqM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946766AbWKAKqM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 05:46:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946767AbWKAKqM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 05:46:12 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:20652 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1946766AbWKAKqL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 05:46:11 -0500
Subject: Re: [PATCH 1/7] paravirtualization: header and stubs for
	paravirtualizing critical operations
From: Arjan van de Ven <arjan@infradead.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andi Kleen <ak@muc.de>, Andi Kleen <ak@suse.de>,
       virtualization@lists.osdl.org, Chris Wright <chrisw@sous-sol.org>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <1162376827.23462.5.camel@localhost.localdomain>
References: <20061029024504.760769000@sous-sol.org>
	 <20061029024607.401333000@sous-sol.org> <200610290831.21062.ak@suse.de>
	 <1162178936.9802.34.camel@localhost.localdomain>
	 <20061030231132.GA98768@muc.de>
	 <1162376827.23462.5.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Intel International BV
Date: Wed, 01 Nov 2006 11:45:25 +0100
Message-Id: <1162377928.23744.4.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-7.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-01 at 21:27 +1100, Rusty Russell wrote:
> Create a paravirt.h header for all the critical operations which need
> to be replaced with hypervisor calls, and include that instead of
> defining native operations, when CONFIG_PARAVIRT.
> 
> This patch does the dumbest possible replacement of paravirtualized
> instructions: calls through a "paravirt_ops" structure.  Currently
> these are function implementations of native hardware: hypervisors
> will override the ops structure with their own variants.
> 
> All the pv-ops functions are declared "fastcall" so that a specific
> register-based ABI is used, to make inlining assember easier.


this is a lot of infrastructure... do we have more than 1 user of this
yet that wants to get merged in mainline?


-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

