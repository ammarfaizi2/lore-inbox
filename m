Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261306AbUKFDXr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261306AbUKFDXr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 22:23:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbUKFDXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 22:23:47 -0500
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:21666 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S261301AbUKFDXW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 22:23:22 -0500
Date: Fri, 5 Nov 2004 19:22:59 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] WIN_* -> ATA_CMD_* conversion: comments
Message-ID: <20041106032259.GA6060@taniwha.stupidest.org>
References: <20041103091101.GC22469@taniwha.stupidest.org> <418AE8C0.3040205@pobox.com> <58cb370e041105051635c15281@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58cb370e041105051635c15281@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2004 at 02:16:05PM +0100, Bartlomiej Zolnierkiewicz wrote:

> On Thu, 04 Nov 2004 21:43:12 -0500, Jeff Garzik <jgarzik@pobox.com> wrote:

> > Chris, a useful follow-up patch (if Bart agrees) is a global
> > search-n-replace of WIN_xxx constants with ATA_CMD_xxx constants.
> > Depending on the size of the patch, it might even need to be split
> > up across several patches.

Following are three patches doing just thus.  They are against bk TOT
with Bart's IDE tree pulled in.

> One ceveat here: hdreg.h and WIN_xxx are (ab)used by user-space so
> for sure there will be complaints (not that we should care :)...

They should fork the values they need then, they are not kernel
specific but come from some nightmarish specification :)


About the following patches:

      The first patch adds missing ATA_CMD_* values which the legacy
      code will need.

      The second patch updates the legacy code (and a couple of
      stragglers) to use the new ATA_CMD_* tokens.

      The third patch removes the (then) redundant cruft from hdreg.h.
