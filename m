Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932285AbWHPWYj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932285AbWHPWYj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 18:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932287AbWHPWYi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 18:24:38 -0400
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:7560
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S932285AbWHPWYi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 18:24:38 -0400
Subject: Re: How to avoid serial port buffer overruns?
From: Paul Fulghum <paulkf@microgate.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Raphael Hertzog <hertzog@debian.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
In-Reply-To: <1155762739.7338.18.camel@mindpipe>
References: <20060816104559.GF4325@ouaza.com>
	 <1155753868.3397.41.camel@mindpipe>  <44E37095.9070200@microgate.com>
	 <1155762739.7338.18.camel@mindpipe>
Content-Type: text/plain
Date: Wed, 16 Aug 2006 17:24:26 -0500
Message-Id: <1155767066.2600.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-16 at 17:12 -0400, Lee Revell wrote:
> 2.6.15 and 2.6.16.  Here is the .config:

Alan's rework of the receive tty buffering went
into 2.6.16 and cured some problems, but clearly not yours.
Some more adjustments are in 2.6.18-rc4, so that
would be interesting to try for diagnosing this.

I was wondering if the problem was interrupt latency,
the tty receive buffering, or something totally different.
I don't know if your problem and Raphael's are caused
by the same mechanism. I would still like to know which
kernel versions he has tried.

Does the MIDI device using the standard N_TTY line discipline?
Are you using the low_latency flag on the serial device?
What type of UART has been tested (16550? other?)
Are you seeing overruns or just lost data?

Thanks,
Paul






