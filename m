Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267648AbUIBGL6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267648AbUIBGL6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 02:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267653AbUIBGL6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 02:11:58 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:52130 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S267648AbUIBGL5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 02:11:57 -0400
To: Chris Wright <chrisw@osdl.org>
Cc: viro@parcelfarce.linux.theplanet.co.uk, discuss@x86-64.org,
       linux-kernel@vger.kernel.org, jmorris@redhat.com
Subject: Re: f_ops flag to speed up compatible ioctls in linux kernel
X-Message-Flag: Warning: May contain useful information
References: <20040901072245.GF13749@mellanox.co.il>
	<20040901073218.GQ16297@parcelfarce.linux.theplanet.co.uk>
	<52zn4a0ysg.fsf@topspin.com> <20040901110225.D1973@build.pdx.osdl.net>
	<52llftzp4m.fsf@topspin.com> <20040901170800.K1924@build.pdx.osdl.net>
	<20040901190122.L1924@build.pdx.osdl.net>
From: Roland Dreier <roland@topspin.com>
Date: Wed, 01 Sep 2004 20:46:14 -0700
In-Reply-To: <20040901190122.L1924@build.pdx.osdl.net> (Chris Wright's
 message of "Wed, 1 Sep 2004 19:01:22 -0700")
Message-ID: <52hdqhwcxl.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 02 Sep 2004 03:46:14.0654 (UTC) FILETIME=[654691E0:01C4909F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Chris> Trivial addition of allowing llseek to become transaction
    Chris> barrier increases this to ~300,000 transactions per second.
    Chris> Patch below gives you some basic idea.

Wow, great stuff.  Thanks a lot for taking the time to try this out.
Also thanks for the original suggestion -- the more I think about the
private filesystem idea the more I like it.

Do you think simple_transaction_llseek() should be merged upstream?
It would definitely make the simple_transaction stuff more useful for
my application.

Thanks,
  Roland
