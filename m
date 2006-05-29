Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750728AbWE2H37@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbWE2H37 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 03:29:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750748AbWE2H37
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 03:29:59 -0400
Received: from gw.openss7.com ([142.179.199.224]:12994 "EHLO gw.openss7.com")
	by vger.kernel.org with ESMTP id S1750728AbWE2H37 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 03:29:59 -0400
Date: Mon, 29 May 2006 01:29:54 -0600
From: "Brian F. G. Bidulock" <bidulock@openss7.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: 4Front Technologies <dev@opensound.com>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>,
       Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: How to check if kernel sources are installed on a system?
Message-ID: <20060529012954.E20649@openss7.org>
Reply-To: bidulock@openss7.org
Mail-Followup-To: Arjan van de Ven <arjan@infradead.org>,
	4Front Technologies <dev@opensound.com>,
	linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
	Heiko Carstens <heiko.carstens@de.ibm.com>
References: <1148835799.3074.41.camel@laptopd505.fenrus.org> <1148838738.21094.65.camel@mindpipe> <1148839964.3074.52.camel@laptopd505.fenrus.org> <1148846131.27461.14.camel@mindpipe> <20060528224402.A13279@openss7.org> <1148878368.3291.40.camel@laptopd505.fenrus.org> <447A883C.5070604@opensound.com> <1148883077.3291.47.camel@laptopd505.fenrus.org> <20060529005705.C20649@openss7.org> <1148886070.3291.54.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1148886070.3291.54.camel@laptopd505.fenrus.org>; from arjan@infradead.org on Mon, May 29, 2006 at 09:01:10AM +0200
Organization: http://www.openss7.org/
Dsn-Notification-To: <bidulock@openss7.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan,

On Mon, 29 May 2006, Arjan van de Ven wrote:
> eh dude what are you thinking? Documentation/kbuild very much gives you
> a FULLY standardized way of doing this. On all distributions.
> The only tricky part is finding the build tree, for the current kernel
> that is
> /lib/modules/`uname -r`/build
> (as per Linus' decree from like 4 to 5 years ago)
> for non-current kernels that's a bit more complex, so just ask the user.
> Once you have that the rest comes for free.

kbuild is fine for small isolated kernel modules that export no symbols
(esp. little ones that nobody supports any more or were recently kicked
out of a kernel), but for building large subsystems of kernel modules
and multiple interdependent packages that export symbols and headers it
is rather lacking.

An, of course, if you want to build kernel modules for 2.4 and 2.6 as
well, kbuild does not help you.

Also, while checking for kernel version on the fine kernel.org kernels
is quite sufficient, it is next to useless on hacked production distro
kernels.  Therefore, one has to locate configured sources and headers
to perform checks to adapt to them.

--brian
