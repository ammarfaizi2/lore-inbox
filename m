Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271849AbTGYAr1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 20:47:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271850AbTGYArZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 20:47:25 -0400
Received: from beta.galatali.com ([216.40.241.205]:17127 "EHLO
	beta.galatali.com") by vger.kernel.org with ESMTP id S271849AbTGYArO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 20:47:14 -0400
Subject: Re: 2.6.0-test1 Adaptec aic7899 Ultra160 SCSI grief
From: Tugrul Galatali <tugrul@galatali.com>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1369182704.1059067061@aslan.btc.adaptec.com>
References: <5F99705E-BDC8-11D7-9859-000A957CBE4C@galatali.com>
	 <1369182704.1059067061@aslan.btc.adaptec.com>
Content-Type: text/plain
Message-Id: <1059094940.386.7.camel@duality.galatali.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 24 Jul 2003 21:02:20 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-07-24 at 13:17, Justin T. Gibbs wrote:
[snip snip] 
> came back with a tag identifier of 0x20.  This looks like a drive
> firmware bug, but a bug in the aic7xxx driver cannot be completely
> ruled out without a SCSI bus trace of the failure.  
[snip snip]

	SCSI bus trace = logging? I started poking around online for how that
works, and I found repeatable case of what I hope is the same error (one
tar from the bad scsi disk piping into another tar onto a good scsi
disk). One problem I ran into is that scsi_logging=X as a kernel
parameter doesn't seem to work in 2.6.0-test1, so I put in a S00 init
script to do the:

echo "scsi log all" > /proc/scsi/scsi

	The resulting /var/log/messages is ~18M, compressed down to 300k.

http://acm.cs.nyu.edu/~tugrul/scsi/messages.bz2

	Is this what you need?

	I did a quick test of the above case on a 2.4.21 kernel and it didn't
seem to trigger anything evil.

	If it turns out to be a firmware problem, is the firmware upgradeable
or do I have to buy a new drive, in which case is there a blacklist?

	Tugrul Galatali




