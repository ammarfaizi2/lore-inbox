Return-Path: <linux-kernel-owner+w=401wt.eu-S1751235AbXANLNH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751235AbXANLNH (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 06:13:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751238AbXANLNH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 06:13:07 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:36317 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751236AbXANLNG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 06:13:06 -0500
Date: Sun, 14 Jan 2007 12:05:13 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Jeremy Fitzhardinge <jeremy@goop.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>,
       Chris Wright <chrisw@sous-sol.org>
Subject: Re: [patch 20/20] XEN-paravirt: Add Xen virtual block device driver.
In-Reply-To: <20070113014649.256179743@goop.org>
Message-ID: <Pine.LNX.4.61.0701141202050.26276@yvahk01.tjqt.qr>
References: <20070113014539.408244126@goop.org> <20070113014649.256179743@goop.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Jan 12 2007 17:45, Jeremy Fitzhardinge wrote:
>
>The block device frontend driver allows the kernel to access block
>devices exported exported by a virtual machine containing a physical
>block device driver.

Is this significantly different from ubd/hostfs that it actually warrants a
reinvention?

>+	(void)xenbus_switch_state(info->xbdev, XenbusStateConnected);

Cast remove, if xenbus_switch_state does not have __must_check.
Also elsewhere.


	-`J'
-- 
