Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261405AbUHJIAP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbUHJIAP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 04:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261638AbUHJIAP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 04:00:15 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:6871 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S261405AbUHJIAC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 04:00:02 -0400
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
From: David Woodhouse <dwmw2@infradead.org>
To: Albert Cahalan <albert@users.sf.net>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       alan@lxorguk.ukuu.org.uk, schilling@fokus.fraunhofer.de, axboe@suse.de
In-Reply-To: <1092082920.5761.266.camel@cube>
References: <1092082920.5761.266.camel@cube>
Content-Type: text/plain
Message-Id: <1092124796.1438.3695.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Tue, 10 Aug 2004 08:59:57 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-09 at 16:22 -0400, Albert Cahalan wrote:
> Joerg:
>    "WARNING: Cannot do mlockall(2).\n"
>    "WARNING: This causes a high risk for buffer underruns.\n"
> Fixed:
>    "Warning: You don't have permission to lock memory.\n"
>    "         If the computer is not idle, the CD may be ruined.\n"
> 
> Joerg:
>    "WARNING: Cannot set priority class parameters priocntl(PC_SETPARMS)\n"
>    "WARNING: This causes a high risk for buffer underruns.\n"
> Fixed:
>    "Warning: You don't have permission to hog the CPU.\n"
>    "         If the computer is not idle, the CD may be ruined.\n"

That seems reasonable, but _only_ if burnfree is not enabled. If the
hardware _supports_ burnfree but it's disabled, the warning should also
recommend turning it on.

-- 
dwmw2


