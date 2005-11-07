Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965079AbVKGXEI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965079AbVKGXEI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 18:04:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965586AbVKGXEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 18:04:08 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:24900 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S965079AbVKGXEG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 18:04:06 -0500
Date: Tue, 8 Nov 2005 00:04:26 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Jan Beulich <JBeulich@novell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] slightly enhance cross builds
Message-ID: <20051107230426.GD10492@mars.ravnborg.org>
References: <436F5D96.76F0.0078.0@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <436F5D96.76F0.0078.0@novell.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2005 at 01:58:46PM +0100, Jan Beulich wrote:
> This adds functionality to default CROSS_COMPILE to a sensible value
> when cross-building (so one doesn't always have to specify this on the
> make command line), as well as storing ARCH and SUBARCH in the
> Makefile
> generated when building outside of the source directory (so that
> subsequent make invocations don't have to always repeat these).

This patch introduce different behaviour with and without make O=
This will result on confusion and is bad.

The right approach is to come up with a patch that works in both cases.

	Sam
