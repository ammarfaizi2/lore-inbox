Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751147AbWAPSpX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbWAPSpX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 13:45:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbWAPSpX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 13:45:23 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:11649 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1751147AbWAPSpV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 13:45:21 -0500
Subject: RE: [PATCH] acpi: remove function tracing macros
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: "Brown, Len" <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B3005B835E4@hdsmsx401.amr.corp.intel.com>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005B835E4@hdsmsx401.amr.corp.intel.com>
Date: Mon, 16 Jan 2006 20:45:19 +0200
Message-Id: <1137437119.10352.9.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Len,

On Mon, 2006-01-16 at 13:14 -0500, Brown, Len wrote:
> >This patch removes function tracing macro usage from drivers/acpi/. In
> >particular, ACPI_FUNCTION_TRACE are ACPI_FUNCTION_NAME removed 
> >completely and return_VALUE, return_PTR, and return_ACPI_STATUS
> >are converted with proper use of return.
> 
> I'm sorry, I can't apply this source clean-up patch.
> 
> We need tracing to debug interpreter failures on hardware
> in the field.

I appreciate that but per-function tracing is overkill. Especially since
the macros used for it are very obfuscating (i.e. return_VALUE, et al)
and we have things like kprobes.

On Mon, 2006-01-16 at 13:14 -0500, Brown, Len wrote:
> When we make GPL changes to those files, we diverge
> from the rest of the universe and the overloaded
> Linux/ACPI maintainer (me) starts to lose his sanity.
> That said, if the author of the patch re-licenses it back
> to Intel so it can be distributed under eitiher GPL or BSD,
> then Intel can apply a change "up-stream" and divergence
> can be avoided.  But per above, that isn't the primary
> issue with ripping out tracing.
> 
> Note that tracing is built in only for CONFIG_ACPI_DEBUG.

My main concern is that the ACPI subsystem uses obfuscating macros to
implement function tracing in the kernel. Please note that we do not
allow this in new code and there are janitor such as myself that are
working to remove the existing ones.

While I have no intention of making your life as Linux maintainer
harder, I would appreciate if you would at least consider ripping out
function tracing from upstream. I am certainly willing to relicense or
even transfer copyrights of the patch if that's what you need.

			Pekka

