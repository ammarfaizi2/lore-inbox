Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264826AbUEKQb0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264826AbUEKQb0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 12:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264873AbUEKQ3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 12:29:09 -0400
Received: from gherkin.frus.com ([192.158.254.49]:16016 "EHLO gherkin.frus.com")
	by vger.kernel.org with ESMTP id S264834AbUEKQ20 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 12:28:26 -0400
Subject: Re: [PATCH] Format Unit can take many hours
In-Reply-To: <Pine.GSO.4.33.0405110952380.14297-100000@sweetums.bluetronic.net>
 "from Ricky Beam at May 11, 2004 10:01:55 am"
To: Ricky Beam <jfbeam@bluetronic.net>
Date: Tue, 11 May 2004 11:28:22 -0500 (CDT)
Cc: Kurt Garloff <garloff@suse.de>,
       Linux SCSI list <linux-scsi@vger.kernel.org>,
       Linux kernel list <linux-kernel@vger.kernel.org>
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20040511162822.C46BFDBDB@gherkin.frus.com>
From: rct@gherkin.frus.com (Bob Tracy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ricky Beam wrote:
> On Tue, 11 May 2004, Kurt Garloff wrote:
> >the timeout for FORMAT_UNIT should be much longer; I've seen 8hrs
> >already (75Gig). I've increased the timeout from 2hrs to 12hrs.
> 
> If you execute a FORMAT_UNIT properly, the timeout is irrelevant.  Set the
> IMMED bit so the command returns as soon as the drive begins processing it.
> Send TEST_UNIT_READY to check the progress.  I'll have to consult the
> spec, but I think support for Immed is required.

Moreover, it simply "feels" wrong to define a constant for something
that isn't...  The quick fix of increasing the timeout doesn't address
the underlying issue of how long a format should take, and as Ricky
implies, that's probably more the concern of the application rather
than the driver.

-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------
