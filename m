Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932561AbWASGYq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932561AbWASGYq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 01:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932564AbWASGYq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 01:24:46 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:56292 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932561AbWASGYp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 01:24:45 -0500
Subject: Re: - add-pselect-ppoll-system-call-implementation-tidy.patch
	removed from -mm tree
From: David Woodhouse <dwmw2@infradead.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060119171708.7f856b42.sfr@canb.auug.org.au>
References: <200601190052.k0J0qmKC009977@shell0.pdx.osdl.net>
	 <1137648119.30084.94.camel@localhost.localdomain>
	 <20060119171708.7f856b42.sfr@canb.auug.org.au>
Content-Type: text/plain
Date: Thu, 19 Jan 2006 17:24:47 +1100
Message-Id: <1137651887.30084.118.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-19 at 17:17 +1100, Stephen Rothwell wrote:
> The limit on the length of lines is 80 columns and this is a hard limit.
> 
> Statements longer than 80 columns will be broken into sensible chunks.
> Descendants are always substantially shorter than the parent and are placed
> substantially to the right. The same applies to function headers with a long
> argument list. Long strings are as well broken into shorter strings.

We can submit patches for the cases where the guidelines listed in
Documentation/CodingStyle diverge from common sense. 

In _some_ cases, the text which one might put after the 80th column is
actually important to the flow of the program and really should be put
back into the 'normal' text area. That's fair enough -- I'm not arguing
that we should leave 80-column text areas behind altogether.

But in this case it's just the length argument to a memcpy, and there's
no real information there. Similarly, people have recently been observed
to start wrapping the strings in debugging printks onto a second line
gratuitously. In _those_ cases, it really is counter-productive -- it's
_fine_ if that text is off the right-hand side of the screen.

If your editor wraps it onto the next line, then that sucks -- but at
least it only sucks for _you_, and you wouldn't really benefit by the
proposed 'fix' anyway, because the proposed 'fix' is just to wrap it so
that it sucks for _all_ of us.

-- 
dwmw2

