Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262023AbVAYRLm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262023AbVAYRLm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 12:11:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262024AbVAYRIt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 12:08:49 -0500
Received: from iPass.cambridge.arm.com ([193.131.176.58]:16013 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S262023AbVAYRI0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 12:08:26 -0500
To: Andrea Arcangeli <andrea@suse.de>
Cc: CVSps@dm.cobite.com, Larry McVoy <lm@bitmover.com>,
       linux-kernel@vger.kernel.org, Andreas Gruenbacher <agruen@suse.de>
Subject: Re: kernel CVS troubles with cvsps
References: <20050125164203.GY7587@dualathlon.random>
From: Catalin Marinas <catalin.marinas@arm.com>
Date: Tue, 25 Jan 2005 17:10:17 +0000
In-Reply-To: <20050125164203.GY7587@dualathlon.random> (Andrea Arcangeli's
 message of "Tue, 25 Jan 2005 17:42:03 +0100")
Message-ID: <tnxsm4po2o6.fsf@arm.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> writes:
> sorry to annoy you about this, but something is going wrong with either
> cvsps or the kernel CVS.
>
> I reproducibly get this as the last changeset, note the date. The
> --bkcvs breaks completely too, but that would be a minor issue since
> cvsps by default will get it right from the dates that are atomic with
> the bk2cvs conversion.

I noticed this problem some time ago when trying to see whether the
darcs repository is consistent with the BK one:

http://marc.theaimsgroup.com/?l=linux-kernel&m=110026570201544&w=2

A solution is to use the "(Logical change ...)" string within each
file's commit log instead of the date (I realised that it is simpler
to write a shell script to generate the diffs rather than modifying
cvsps).

Catalin

