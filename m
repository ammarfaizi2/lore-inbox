Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264788AbTFESUh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 14:20:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264803AbTFESUh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 14:20:37 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:26125
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S264788AbTFESUg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 14:20:36 -0400
Date: Thu, 5 Jun 2003 11:34:08 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Ed Vance <EdV@macrolink.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [2.5] Non-blocking write can block
Message-ID: <20030605183408.GB3291@matchmail.com>
Mail-Followup-To: Davide Libenzi <davidel@xmailserver.org>,
	Ed Vance <EdV@macrolink.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <11E89240C407D311958800A0C9ACF7D1A33EBD@EXCHANGE> <Pine.LNX.4.55.0306041717230.3655@bigblue.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0306041717230.3655@bigblue.dev.mcafeelabs.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 04, 2003 at 05:19:05PM -0700, Davide Libenzi wrote:
> Besides the stupid name O_REALLYNONBLOCK, it really should be different
> from both O_NONBLOCK and O_NDELAY. Currently in Linux they both map to the
> same value, so you really need a new value to not break binary compatibility.

Hmm, wouldn't that be source and binary compatability?  If an app used
O_NDELAY and O_NONBLOCK interchangably, then a change to O_NDELAY would
break source compatability too.

Also, what do other UNIX OSes do?  Do they have seperate semantics for
O_NONBLOCK and O_NDELAY?  If so, then it would probably be better to change
O_NDELAY to be similar and add another feature at the same time as reducing
platform specific codeing in userspace.
