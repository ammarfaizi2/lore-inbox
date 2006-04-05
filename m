Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932102AbWDEWH1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932102AbWDEWH1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 18:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932103AbWDEWH0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 18:07:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:53888 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932102AbWDEWH0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 18:07:26 -0400
From: Andreas Gruenbacher <agruen@suse.de>
Organization: SUSE Labs / Novell Inc.
To: Valdis.Kletnieks@vt.edu
Subject: Re: [PATCH] modules_install must not remove existing modules
Date: Thu, 6 Apr 2006 00:06:30 +0200
User-Agent: KMail/1.8.2
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
References: <200604052333.51085.agruen@suse.de> <200604052152.k35LqtQ0032100@turing-police.cc.vt.edu>
In-Reply-To: <200604052152.k35LqtQ0032100@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604060006.30759.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 05 April 2006 23:52, Valdis.Kletnieks@vt.edu wrote:
> Can this be re-worked to ensure that it clears the target directory
> the *first* time?  It would suck mightily if a previous build of 2.6.17-rc2
> left a net_foo.ko lying around to get insmod'ed by accident (consider the
> case of CONFIG_NETFOO=m getting changed to y or n, and other possible
> horkage. Module versioning will catch some, but not all, of this crap....)

We could wipe away everything in the non-external modules_install case (not 
only everything below kernel/ as is done now). The problem here is that 
different external modules_install calls into the same dir conflict.

Andreas
