Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261392AbVC2UP4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261392AbVC2UP4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 15:15:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261366AbVC2UNy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 15:13:54 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:485 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261350AbVC2ULl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 15:11:41 -0500
Subject: Re: Mac mini sound woes
From: Lee Revell <rlrevell@joe-job.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <s5hu0mugsg2.wl@alsa2.suse.de>
References: <1111966920.5409.27.camel@gaston>
	 <1112067369.19014.24.camel@mindpipe> <s5h8y46kbx7.wl@alsa2.suse.de>
	 <1112094290.6577.19.camel@gaston> <1112123109.4922.3.camel@mindpipe>
	 <s5hu0mugsg2.wl@alsa2.suse.de>
Content-Type: text/plain
Date: Tue, 29 Mar 2005 15:11:37 -0500
Message-Id: <1112127097.5141.1.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-29 at 21:31 +0200, Takashi Iwai wrote:
> Well I don't remember the discussion thread on alsa-devel about this,
> but it's a good idea that alsa-lib checks the capability of hw-mixing
> and apples dmix only if necessary.  (In the case of softvol, it can
> check the existence of hw control by itself, though.)
> 
> Currently, dmix is enabled per driver-type base.  That is, dmix is set
> to default in each driver's configuration which is known to have no hw
> mixing functionality.

It was not discussed at length.

Anyway, I think you can detect hardware mixing support comparing the
number of substreams to the numebr of streams for a device.  If the
ratio is greater than 1, hardware mixing is supported.

Lee

