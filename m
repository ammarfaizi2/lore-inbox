Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262028AbTFIVTY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 17:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262093AbTFIVTY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 17:19:24 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:65042 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP id S262028AbTFIVTX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 17:19:23 -0400
Date: Mon, 09 Jun 2003 15:32:11 +0000
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Reply-To: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
cc: linux-kernel@vger.kernel.org, willy@w.ods.org, gibbs@scsiguy.com,
       marcelo@conectiva.com.br, green@namesys.com
Subject: Re: Undo aic7xxx changes (now rc7+aic20030603)
Message-ID: <122650000.1055172730@caspian.scsiguy.com>
In-Reply-To: <20030609171011.7f940545.skraw@ithnet.com>
References: <Pine.LNX.4.55L.0305071716050.17793@freak.distro.conectiva>	<2804790000.1052441142@aslan.scsiguy.com>	<20030509120648.1e0af0c8.skraw@ithnet.com>	<20030509120659.GA15754@alpha.home.local>	<20030509150207.3ff9cd64.skraw@ithnet.com>	<20030605181423.GA17277@alpha.home.local>	<20030608131901.7cadf9ea.skraw@ithnet.com>	<20030608134901.363ebe42.skraw@ithnet.com> <20030609171011.7f940545.skraw@ithnet.com>
X-Mailer: Mulberry/3.0.3 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> For Justin:
> Thank you for your continous openness and support in the whole issue in form
> of exactly _zero_ comments (,besides "how do you know aic is to blame?").

Stephan,

Other than your most recent complaint that the driver doesn't function
correctly in an SMP kernel when you specify the nosmp option, you have
yet to provide any information that points to a problem in the aic7xxx
driver.  Without such information, I'm at a loss to help you.  One thing
that you forgot to mention in your "report" is that data corruption can
happen in many more places than just in the aic7xxx driver.  The data
could be corrupted by a VM bug, a buffer layer bug, or a filesystem
bug.  When testing our drivers against RHAS2.1 we found that the stock
kernel had data corruption issues very similar to what your are talking
about when run on very fast, hyperthreading, SMP machines.  The data
corruption occurred with any SCSI controller we tried, regardless of vendor.
If you continue to feel that the aic7xxx driver is at fault, I encourage you
to try to reproduce this failure with someone elses card.  I think you'll
find that the problem persists even with this change.

I will be more than happy to look into why the aic7xxx driver may not
operate correctly in an SMP kernel with the nosmp option.  Considering
that your complaint about this failure came into my email box just
yesterday, perhaps you can give me just a few days to look into this
before you decide to call me unresponsive.  Since I'm attending a
conference this whole week, I won't even be able to look at this
until I return on Monday of next week.

I'm sorry that you are experiencing data corruption.  I take those
issues very seriously, but all of your panics and other reports point
to issues elsewhere in the kernel that should be resolved before you
conclude that the data corruption you are experiencing is somehow
the aic7xxx driver's fault.  I'll be more than happy to fess up to
and correct any defect that is found in the driver, but I cannot fix
bugs that I cannot reproduce and that have no usable debugging information
associated with them.

--
Justin

