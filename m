Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262179AbVCUXCc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262179AbVCUXCc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 18:02:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262184AbVCUW7E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 17:59:04 -0500
Received: from orb.pobox.com ([207.8.226.5]:40337 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S262179AbVCUW4d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 17:56:33 -0500
Date: Mon, 21 Mar 2005 16:56:26 -0600
From: Nathan Lynch <ntl@pobox.com>
To: Paul Mackerras <paulus@samba.org>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, akpm@osdl.org,
       linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.6.12-rc1-mm1] fix compile error in ppc64 prom.c
Message-ID: <20050321225626.GD16469@otto>
References: <200503211519.j2LFJ1os021884@harpo.it.uu.se> <16959.17091.901784.666693@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16959.17091.901784.666693@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2005 at 08:55:15AM +1100, Paul Mackerras wrote:
> Mikael Pettersson writes:
> 
> > Compiling 2.6.12-rc1-mm1 for ppc64 fails with:
> > 
> > arch/ppc64/kernel/prom.c:1691: error: syntax error before 'prom_reconfig_notifier'
> 
> Currently prom.c is in a mess because Linus applied the last 2 of 8
> patches from Nathan Lynch but not the first 6.  :-P

Actually, this one is my fault, although unless I'm really missing
something gcc 3.4.2 silently accepts the invalid syntax.

All eight of the patches from the pSeries reconfig series are present
in 2.6.12-rc1-mm1.  The error Mikael reported is unrelated to the
state of Linus' tree, and his patch is correct.  (The mistake is
present in both versions of the patches which I posted for review on
linuxppc64-dev; nobody caught it.)


Nathan
