Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265156AbUELSSR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265156AbUELSSR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 14:18:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265138AbUELSSR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 14:18:17 -0400
Received: from holomorphy.com ([207.189.100.168]:9401 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265156AbUELSSE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 14:18:04 -0400
Date: Wed, 12 May 2004 11:11:15 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: David Mosberger-Tang <davidm@hpl.hp.com>, linux-ia64@linuxia64.org,
       linux-kernel@vger.kernel.org
Subject: Re: GCC nested functions?
Message-ID: <20040512181115.GE1397@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Stephen Hemminger <shemminger@osdl.org>,
	David Mosberger-Tang <davidm@hpl.hp.com>, linux-ia64@linuxia64.org,
	linux-kernel@vger.kernel.org
References: <20040512105924.54a8211b@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040512105924.54a8211b@dell_ss3.pdx.osdl.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2004 at 10:59:24AM -0700, Stephen Hemminger wrote:
> I used GCC nested functions in the (not released) bridge sysfs
> interface for 2.6.6. It seemed like a nice way to express the sysfs
> related interface without doing lots of code copying (or worse lots
> of macros).

Upward funargs are rather easy to trip over (though you haven't tripped
over them) and the runtime shits itself badly on all architectures when
they happen. It's too dangerous to be allowed to be used.

The code you posted doesn't really have a reason to use nested functions
(i.e. downward funargs aren't being used).


-- wli
