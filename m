Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422687AbVLOKKF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422687AbVLOKKF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 05:10:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422688AbVLOKKE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 05:10:04 -0500
Received: from uucp.cistron.nl ([62.216.30.38]:26795 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S1422686AbVLOKKC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 05:10:02 -0500
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: [GIT PATCH] final SCSI fixes for 2.6.15-rc5
Date: Thu, 15 Dec 2005 10:10:01 +0000 (UTC)
Organization: Cistron
Message-ID: <dnrfdp$6nl$1@news.cistron.nl>
References: <1134604909.11150.2.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1134641401 6901 194.109.0.112 (15 Dec 2005 10:10:01 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: mikevs@n2o.xs4all.nl (Miquel van Smoorenburg)
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1134604909.11150.2.camel@mulgrave>,
James Bottomley  <James.Bottomley@SteelEye.com> wrote:
>These should (hopefully) represent the last few urgent bug fixes that
>have shown up.  The fixes are available here:
>
>master.kernel.org:/pub/scm/linux/kernel/git/jejb/scsi-rc-fixes-2.6.git

While not technically a SCSI driver, dpt_i2o lives in drivers/scsi
and there is a critical fix in the -mm tree that needs to go
into 2.6.15:

dpt_i2o-fix-for-deadlock-condition.patch

I've experienced several hard lockups in dpt_i2o and I have reports
of other people that have the same problem - they are solved with
this patch. It's a pure bugfix, in 2.6.13 the scsi error recovery
api was changed wrt locking and dpt_i2o only got partially updated.

It probably needs to go into 2.6.14.stable too..

Mike.

