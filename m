Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265943AbUHIETZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265943AbUHIETZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 00:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265930AbUHIETZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 00:19:25 -0400
Received: from mailhub.hp.com ([192.151.27.10]:57555 "EHLO mailhub.hp.com")
	by vger.kernel.org with ESMTP id S265943AbUHIETW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 00:19:22 -0400
Subject: Re: [PATCH] cleanup ACPI numa warnings
From: Alex Williamson <alex.williamson@hp.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Paul Jackson <pj@sgi.com>, mbligh@aracnet.com, haveblue@us.ibm.com,
       acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20040808143631.7c18cae9.rddunlap@osdl.org>
References: <1091738798.22406.9.camel@tdi>
	 <1091739702.31490.245.camel@nighthawk> <1091741142.22406.28.camel@tdi>
	 <249150000.1091763309@[10.10.2.4]>
	 <20040805205059.3fb67b71.rddunlap@osdl.org>
	 <20040807105729.6adea633.pj@sgi.com>
	 <20040808143631.7c18cae9.rddunlap@osdl.org>
Content-Type: text/plain
Date: Sun, 08 Aug 2004 22:19:44 -0600
Message-Id: <1092025184.2292.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.92.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-08-08 at 14:36 -0700, Randy.Dunlap wrote:
> On Sat, 7 Aug 2004 10:57:29 -0700 Paul Jackson wrote:
> 
> | > And there's nothing in CodingStyle that agrees with you that I could find.
> | 
> | >From the file Documentation/SubmittingPatches:
> | 
> |         3) 'static inline' is better than a macro
> |
> Oops.  Thanks, Paul.

   Ok, I was all set to switch to static inlines, but it doesn't work.
Compiling w/ debug on, _dbg is undefined, which is part of the
ACPI_DB_INFO macro, but it only gets setup by the ACPI_FUNCTION_NAME
macro.  Guess I got lucky by choosing to do it as a macro.  IMHO, it
doesn't really make sense to make the static inline functions more
complicated or hide where they're getting called to make this all work.
So, I think the choices are to stick with the ugly macros or put #ifdefs
around the code and essentially leave it the way it is.  Sorry I didn't
give it a more thorough look when originally questioned.  Better ideas?
Thanks,

	Alex

