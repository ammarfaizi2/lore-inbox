Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965228AbVKGSVF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965228AbVKGSVF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 13:21:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965224AbVKGSVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 13:21:05 -0500
Received: from ra.tuxdriver.com ([24.172.12.4]:34057 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S965162AbVKGSVC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 13:21:02 -0500
Date: Mon, 7 Nov 2005 13:20:34 -0500
From: "John W. Linville" <linville@tuxdriver.com>
To: Pantelis Antoniou <panto@intracom.gr>
Cc: linuxppc-embedded@ozlabs.org, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 2.6.14] fec_8xx: make CONFIG_FEC_8XX depend on CONFIG_8xx
Message-ID: <20051107182031.GC13797@tuxdriver.com>
Mail-Followup-To: Pantelis Antoniou <panto@intracom.gr>,
	linuxppc-embedded@ozlabs.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20051106025701.GA9698@tuxdriver.com> <436F07F5.1030206@intracom.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <436F07F5.1030206@intracom.gr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2005 at 09:53:25AM +0200, Pantelis Antoniou wrote:
> John W. Linville wrote:

> >@@ -1,6 +1,6 @@
> > config FEC_8XX
> > 	tristate "Motorola 8xx FEC driver"
> >-	depends on NET_ETHERNET
> >+	depends on NET_ETHERNET && 8xx
> > 	select MII
> > 
> > config FEC_8XX_GENERIC_PHY
> 
> Yes, this is the correct approach. Please disregard the other
> patches floating about.

Pretty sure you are right.  However, a broken version already got
committed.  It added FEC as a dependency.  That keeps it from breaking
everyone else, but it make the driver available for Coldfire rather
than for PPC 8xx...

I'll reform that patch and repost.

John
-- 
John W. Linville
linville@tuxdriver.com
