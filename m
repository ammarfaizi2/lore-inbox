Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261958AbVEDXXM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261958AbVEDXXM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 19:23:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261955AbVEDXXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 19:23:11 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18820 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261958AbVEDXXJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 19:23:09 -0400
Date: Thu, 5 May 2005 00:23:38 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Pavel Roskin <proski@gnu.org>
Cc: linux <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Saving ARCH and CROSS_COMPILE in generated Makefile
Message-ID: <20050504232338.GF18977@parcelfarce.linux.theplanet.co.uk>
References: <1115248267.12758.21.camel@dv.roinet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1115248267.12758.21.camel@dv.roinet.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 04, 2005 at 07:11:07PM -0400, Pavel Roskin wrote:
> Unfortunately, builds in the source directory would not profit from this
> patch.  Perhaps we could always generate "makefile" or "GNUmakefile" in
> the build directory, but it would be another patch.  Anyway, few people
> cross-compile their kernels, and it's not unreasonable to encourage them
> to use out-of-tree builds.
> 
> SUBARCH is not saved on purpose, since users are not supposed to
> override it.

WTF not?  Consider, e.g. uml/i386 and uml/amd64.

In any case, there's no reason to mess with that at all.  This stuff is
trivally dealt with by a wrapper script that takes target name as its
first argument (the rest is passed to make unchanged) and figures out
ARCH, CROSS_COMPILE, SUBARCH and build directory by it.  End of story.
