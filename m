Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261385AbTDDUQg (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 15:16:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261386AbTDDUQg (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 15:16:36 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:5000 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S261385AbTDDUQe (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 4 Apr 2003 15:16:34 -0500
Date: Fri, 4 Apr 2003 21:27:44 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Andrew Morton <akpm@digeo.com>
Cc: torvalds@transmeta.com, jjs@tmsusa.com, andrew.grover@intel.com,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] acpi compile fix
Message-ID: <20030404202744.GG29047@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Andrew Morton <akpm@digeo.com>, torvalds@transmeta.com,
	jjs@tmsusa.com, andrew.grover@intel.com,
	linux-kernel@vger.kernel.org
References: <20030403130505.199294c7.akpm@digeo.com> <20030404121812.GA23352@suse.de> <20030404115756.66d87211.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030404115756.66d87211.akpm@digeo.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 04, 2003 at 11:57:56AM -0800, Andrew Morton wrote:

 > I think acpi_handle_t is "an opaque type specific to the OS on which the APCI
 > code happens to be running".

I don't see how putting a spinlock_t cast in the code is any more
portable between OS's than spinlock_t as a function parameter.

 > If the above guesses (I'd prefer not to look) are correct then
 > 	struct acpi_handle_t {
 > 		spinlock_t lock;
 > 	};
 > 
 > would make a ton more sense.

That would solve the portability argument in my eyes if that is
indeed the case here. It's still ugly, but it at least kills
the problem in a slightly more tasteful way.

		Dave

