Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265538AbUAPPtJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 10:49:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265546AbUAPPtJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 10:49:09 -0500
Received: from jik.kamens.brookline.ma.us ([66.92.77.120]:48016 "EHLO
	jik.kamens.brookline.ma.us") by vger.kernel.org with ESMTP
	id S265538AbUAPPtG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 10:49:06 -0500
From: Jonathan Kamens <jik@kamens.brookline.ma.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16392.2027.90408.850335@jik.kamens.brookline.ma.us>
Date: Fri, 16 Jan 2004 10:48:59 -0500
To: John Bradford <john@grabjohn.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Updated on UDMA BadCRC errors + subsequent problems (was: Is it safe to ignore UDMA BadCRC errors?)
In-Reply-To: <200401161546.i0GFkkpa002053@81-2-122-30.bradfords.org.uk>
References: <16368.20794.147453.255239@jik.kamens.brookline.ma.us>
	<16389.63781.783923.930112@jik.kamens.brookline.ma.us>
	<16391.24288.194579.471295@jik.kamens.brookline.ma.us>
	<200401160747.i0G7ln1I000368@81-2-122-30.bradfords.org.uk>
	<16392.734.505550.6731@jik.kamens.brookline.ma.us>
	<200401161546.i0GFkkpa002053@81-2-122-30.bradfords.org.uk>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-Bogosity: No, tests=bogofilter
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Bradford writes:

 > Maybe not - the most common cause I've seen for that message in the
 > logs is trying to access S.M.A.R.T. information when S.M.A.R.T. is
 > disabled.
 > 
 > I.E. the error should be reproducable with:
 > 
 > # smartctl -d /dev/hda
 > # smartctl -a /dev/hda
 > 
 > Are you sure you weren't trying to get S.M.A.R.T. info from the
 > drive at the time the error was logged?

My smartctl wants "-s off" rather than "-d", but other than that,
you're correct, that sequence of commands does ause the same error to
appear in the logs.  But why/how would SMART be disabled on the drive?
I've been running smartd on the drive for weeks with no errors of this
sort, and I fail to see how SMART would suddenly be disabled on the
drive with no action on my part, so it seems more likely that some
other condition caused the error.

Thanks,

  jik
