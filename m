Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964935AbWALBPt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964935AbWALBPt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 20:15:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964936AbWALBPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 20:15:49 -0500
Received: from canuck.infradead.org ([205.233.218.70]:23783 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S964935AbWALBPs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 20:15:48 -0500
Subject: Re: + add-pselect-ppoll-system-call-implementation-tidy.patch
	added to -mm tree
From: David Woodhouse <dwmw2@infradead.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200601120105.k0C15QdV021028@shell0.pdx.osdl.net>
References: <200601120105.k0C15QdV021028@shell0.pdx.osdl.net>
Content-Type: text/plain
Date: Thu, 12 Jan 2006 01:15:32 +0000
Message-Id: <1137028532.4196.179.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-11 at 17:05 -0800, akpm@osdl.org wrote:
> -                       memcpy(&current->saved_sigmask, &sigsaved, sizeof(sigsaved));
> +                       memcpy(&current->saved_sigmask, &sigsaved,
> +                                       sizeof(sigsaved));


I often use an editor in an 80x25 terminal to edit code, and I object to
this kind of patch because it make the code _harder_ to read on such a
terminal.

In 99.9% of cases, you don't _care_ about double-checking precisely what
the third argument to that memcpy is. You glance at the line of code and
it's obvious what's happening. It's _better_ if it's off the right-hand
side of the screen rather than being moved down to take up a line all of
its own. You just wasted one more of my precious 25 lines.

The same goes for printks, where I've seen people actually break up
strings and move them onto multiple lines. In the common case, we just
don't _care_ -- what fits onto the first 80 columns is _enough_.

Please don't make this kind of change.

-- 
dwmw2

