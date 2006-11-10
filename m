Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424321AbWKJAzV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424321AbWKJAzV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 19:55:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424322AbWKJAzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 19:55:21 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:64225 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1424321AbWKJAzT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 19:55:19 -0500
Date: Fri, 10 Nov 2006 11:54:36 +1100
From: David Chinner <dgc@sgi.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Alasdair G Kergon <agk@redhat.com>,
       Eric Sandeen <sandeen@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, dm-devel@redhat.com,
       Srinivasa DS <srinivasa@in.ibm.com>,
       Nigel Cunningham <nigel@suspend2.net>, David Chinner <dgc@sgi.com>
Subject: Re: [PATCH 2.6.19 5/5] fs: freeze_bdev with semaphore not mutex
Message-ID: <20061110005436.GN8394166@melbourne.sgi.com>
References: <20061107183459.GG6993@agk.surrey.redhat.com> <200611091652.34649.rjw@sisk.pl> <20061109160003.GA24156@elf.ucw.cz> <200611092059.48722.rjw@sisk.pl> <20061109211722.GA2616@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061109211722.GA2616@elf.ucw.cz>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2006 at 10:17:22PM +0100, Pavel Machek wrote:
> Why not simply &~ PF_NOFREEZE on that particular process? Filesystems
> are free to use threads/work queues/whatever, but refrigerator should
> mean "no writes to filesystem" for them...

Freezing the filesytem is the way to tell the filesystem "no more
writes to the filesytem".

Cheers,

Dave.
-- 
Dave Chinner
Principal Engineer
SGI Australian Software Group
