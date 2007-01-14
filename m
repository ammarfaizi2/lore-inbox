Return-Path: <linux-kernel-owner+w=401wt.eu-S1751242AbXANLYP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751242AbXANLYP (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 06:24:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbXANLYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 06:24:15 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:50847 "EHLO
	mtagate4.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751242AbXANLYO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 06:24:14 -0500
Date: Sun, 14 Jan 2007 13:24:12 +0200
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>,
       Chris Wright <chrisw@sous-sol.org>
Subject: Re: [patch 20/20] XEN-paravirt: Add Xen virtual block device driver.
Message-ID: <20070114112412.GA32719@rhun.haifa.ibm.com>
References: <20070113014539.408244126@goop.org> <20070113014649.256179743@goop.org> <Pine.LNX.4.61.0701141202050.26276@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0701141202050.26276@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 14, 2007 at 12:05:13PM +0100, Jan Engelhardt wrote:

> >+	(void)xenbus_switch_state(info->xbdev, XenbusStateConnected);
> 
> Cast remove, if xenbus_switch_state does not have __must_check.
> Also elsewhere.

Hmm, why? this way you know that the programmer isn't checking the
return value *on purpose*. More information is good.

Cheers,
Muli
