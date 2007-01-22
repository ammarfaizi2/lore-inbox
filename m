Return-Path: <linux-kernel-owner+w=401wt.eu-S1751830AbXAVM4k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751830AbXAVM4k (ORCPT <rfc822;w@1wt.eu>);
	Mon, 22 Jan 2007 07:56:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751826AbXAVM4k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Jan 2007 07:56:40 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:1154 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751763AbXAVM4j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Jan 2007 07:56:39 -0500
Date: Mon, 22 Jan 2007 12:51:45 +0000
From: Pavel Machek <pavel@ucw.cz>
To: "Seshadri, Harinarayanan" <harinarayanan.seshadri@intel.com>
Cc: linux-pm@lists.osdl.org, linux-acpi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH] Power S3 Resume Optimization Patch. Request for Comment
Message-ID: <20070122125145.GA4276@ucw.cz>
References: <20070119092936.GA5590@ucw.cz> <5B3EF00AF56209498A59172917BFE8130168F0B6@bgsmsx412.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B3EF00AF56209498A59172917BFE8130168F0B6@bgsmsx412.gar.corp.intel.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> My initial idea was to execute only block device resume on the separate
> thread, as it take almost 80% of the total device resume time ( I did

If you do this in one block driver that is slow for you (sata?), then it is
probably acceptable. (Maintainer decides.) I'd encourage that option.

If you want to do it for _all_ block devices, you'll probably have to
audit all of them. _Lot_ of work.
							Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
