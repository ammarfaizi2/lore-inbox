Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261205AbUL1Ljt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261205AbUL1Ljt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 06:39:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261768AbUL1Ljt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 06:39:49 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:26314 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S261205AbUL1Ljr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 06:39:47 -0500
Date: Tue, 28 Dec 2004 12:39:47 +0100
From: bert hubert <ahu@ds9a.nl>
To: Gildas LE NADAN <gildas.le-nadan@inha.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: unkillable processes using samba, xfs and lvm2 snapshots (k 2.6.10)
Message-ID: <20041228113946.GA10807@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Gildas LE NADAN <gildas.le-nadan@inha.fr>,
	linux-kernel@vger.kernel.org
References: <41D14251.4030704@inha.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41D14251.4030704@inha.fr>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 28, 2004 at 12:24:01PM +0100, Gildas LE NADAN wrote:

> I experience hangs on samba processes on a filer using xfs over lvm2 as 
> data partitions, when there is active snapshots of the xfs partitions.

A trick is to enable alt-sysrq and press alt-sysrq-t (I think) which spams
your syslog with backtraces of all processes currently running, including
the ones stuck in 'D' state (ps aux | grep " D ").

If you isolate these backtraces and send them to this list, they will enable
developers to help you. Make sure you add 'includes backtrace' in your
Subject.

> Testings showed that the result was the same, whether the snapshots were 
> mounted or not : smbd processes are locked and unkillable while the 
> machine is normaly working otherwise, except software reboot is 
> impossible and hardware reset is needed.

For maximum usefulness, make your setup as simple as possible and reproduce.

Good luck - I personally can't help you in any real way, except to help you
get the debugging information that is needed.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
