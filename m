Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261661AbTI3SrU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 14:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261649AbTI3SrT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 14:47:19 -0400
Received: from fw.osdl.org ([65.172.181.6]:4562 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261661AbTI3SrQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 14:47:16 -0400
Date: Tue, 30 Sep 2003 11:39:04 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: david@luyer.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: Cosmetic error: 2.4.20 bootup and >2^31 sector SCSI devices
Message-Id: <20030930113904.6d82e2a9.rddunlap@osdl.org>
In-Reply-To: <20030929102022.GB14176@pacific.net.au>
References: <20030929102022.GB14176@pacific.net.au>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Sep 2003 20:20:22 +1000 david@luyer.net wrote:

| This looks like it's using some signed numbers that should be unsigned:
| 
| SCSI device sdc: -876998784 512-byte hdwr sectors (-449022 MB)
| 
| However all the tools (mkfs etc) work correctly and work out the correct
| drive size (~1.75Tb):
| 
| /dev/sdc              1.7T  465G  1.2T  27% /usr/local/netflow/data
| 
| Apologies if it's already fixed in later 2.4.x.

I checked 2.4.22:  it uses unsigned instead of signed values.
I checked 2.6.0-test4:  it uses long long data types there, even better.

--
~Randy
