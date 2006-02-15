Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945907AbWBOMB0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945907AbWBOMB0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 07:01:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945909AbWBOMB0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 07:01:26 -0500
Received: from aun.it.uu.se ([130.238.12.36]:34221 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S1945907AbWBOMBZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 07:01:25 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17395.5672.693046.262274@alkaid.it.uu.se>
Date: Wed, 15 Feb 2006 12:53:12 +0100
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Paul Mackerras <paulus@samba.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Roger Leigh <rleigh@whinlatter.ukfsn.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       debian-powerpc@lists.debian.org
Subject: Re: 2.6.16-rc2 powerpc timestamp skew
In-Reply-To: <17394.48045.253033.885865@cargo.ozlabs.ibm.com>
References: <87pslspkj5.fsf@hardknott.home.whinlatter.ukfsn.org>
	<1139779983.5247.39.camel@localhost.localdomain>
	<87irrj85vp.fsf@hardknott.home.whinlatter.ukfsn.org>
	<1139870065.5237.26.camel@localhost.localdomain>
	<17394.48045.253033.885865@cargo.ozlabs.ibm.com>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Mackerras writes:
 > Benjamin Herrenschmidt writes:
 > 
 > > Ok, does not using NTP fixes it ?
 > 
 > Try this patch.  With this the values from gettimeofday() or the VDSO
 > should stay exactly in sync with xtime even if NTP is adjusting the
 > clock.
 > 
 > This patch still has quite a few debugging printks in it, so it's not
 > final by any means.  I'll be interested to hear how it goes, and in
 > particular whether or not you see any "oops, time got ahead" messages.

This patch fixed the clock skew issues (warnings from 'make' while
building new kernels) my G4 eMac has been having since about 2.6.15.
User-space is YDL4.0 and ntpd is used to maintain a correct clock.

/Mikael
