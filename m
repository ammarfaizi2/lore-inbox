Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750760AbWAXV4j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbWAXV4j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 16:56:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750761AbWAXV4i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 16:56:38 -0500
Received: from main.gmane.org ([80.91.229.2]:37060 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750760AbWAXV4i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 16:56:38 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Orion Poplawski <orion@cora.nwra.com>
Subject: Re: [PATCH 3/7] [hrtimers] Fix oldvalue return in setitimer
Date: Tue, 24 Jan 2006 14:56:02 -0700
Message-ID: <dr67pj$uom$1@sea.gmane.org>
References: <20060120021336.134802000@tglx.tec.linutronix.de> <20060120021342.498532000@tglx.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: inferno.cora.nwra.com
User-Agent: Thunderbird 1.5 (X11/20060112)
In-Reply-To: <20060120021342.498532000@tglx.tec.linutronix.de>
X-Enigmail-Version: 0.94.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Thomas Gleixner wrote:
> This resolves bugzilla bug#5617. The oldvalue of the
> timer was read after the timer was cancelled, so the
> remaining time was always zero.
> 

I'm seeing this problem on recent Fedore development kernels.
Interestingly, it causes the IDL 7 minute timed demo to exit immediately
upon trying to plot since it resets the timer and expects the old value
to be returned.

- - Orion
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFD1qJyORnzrtFC2/sRAnp4AJ9ZQ/E0huj2sk8TOxF/1QF7OnrtQQCdHwsT
g0YGeKL3Co9isimpQJ8f3mU=
=R+Z4
-----END PGP SIGNATURE-----

