Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264678AbTFARbO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 13:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264679AbTFARbO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 13:31:14 -0400
Received: from scaup.mail.pas.earthlink.net ([207.217.120.49]:48867 "EHLO
	scaup.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S264678AbTFARbN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 13:31:13 -0400
Subject: Re: Strange load issues with 2.5.69/70 in both -mm and -bk trees.
From: Tom Sightler <ttsig@tuxyturvy.com>
To: Mike Galbraith <efault@gmx.de>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <5.2.0.9.2.20030601084615.00ce6e30@pop.gmx.net>
References: <5.2.0.9.2.20030601084615.00ce6e30@pop.gmx.net>
Content-Type: text/plain
Organization: 
Message-Id: <1054489407.1722.50.camel@iso-8590-lx.zeusinc.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 01 Jun 2003 13:43:27 -0400
Content-Transfer-Encoding: 7bit
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-3.3, required 10,
	AWL, EMAIL_ATTRIBUTION, IN_REP_TO, REFERENCES, SPAM_PHRASE_00_01)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-06-01 at 02:54, Mike Galbraith wrote:
> 
> Hi,
> 
> Wine is the shockwave plugin server right?  You reniced _wine_ and the 
> problem went away?
> 
>          -Mike 
> 

Yes, this is correct.  It's showed as pluginserver in the 'ps ax' output
but I've since noticed that it is simply a symlink to wine.  Of the two
wine processes, wine and wineserver, it was the wine frontend process
that was getting all of the CPU, showing 100% utilization.  Renicing the
wine process made the problem go away.

Running the exact same config on a 2.4.20 kernel uses only a few % of
the CPU.

Later,
Tom


