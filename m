Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261497AbUC3Wjs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 17:39:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261498AbUC3Wjs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 17:39:48 -0500
Received: from uslink-66.173.43-133.uslink.net ([66.173.43.133]:37791 "EHLO
	dingdong.cryptoapps.com") by vger.kernel.org with ESMTP
	id S261497AbUC3Wg2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 17:36:28 -0500
Date: Tue, 30 Mar 2004 14:36:25 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Chris Mason <mason@suse.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] barrier patch set
Message-ID: <20040330223625.GA1245@dingdong.cryptoapps.com>
References: <20040319153554.GC2933@suse.de> <200403201723.11906.bzolnier@elka.pw.edu.pl> <1079800362.11062.280.camel@watt.suse.com> <200403201805.26211.bzolnier@elka.pw.edu.pl> <1080662685.1978.25.camel@sisko.scot.redhat.com> <1080674384.3548.36.camel@watt.suse.com> <1080683417.1978.53.camel@sisko.scot.redhat.com> <4069F2FC.90003@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4069F2FC.90003@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> For IDE, O_DIRECT and O_SYNC can use special "FUA" commands, which
> don't return until the data is on the platter.

On modern drives how reliable is this?  At one point disk-scrubbing
software which used FUA (to ensure data was being written to the
platters) showed that some drives completely ignore this.

Has the state of things changed significantly that we can assume this
is very rare or might we need to have to kind of whitelist/blacklist
system?


    --cw
