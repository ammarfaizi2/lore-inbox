Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751283AbWAENgA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbWAENgA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 08:36:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbWAENgA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 08:36:00 -0500
Received: from [81.2.110.250] ([81.2.110.250]:60066 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1751180AbWAENf7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 08:35:59 -0500
Subject: Re: oops pauser.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060105045212.GA15789@redhat.com>
References: <20060105045212.GA15789@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 05 Jan 2006 13:37:33 +0000
Message-Id: <1136468254.16358.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2006-01-04 at 23:52 -0500, Dave Jones wrote:
> With this patch, if we oops, there's a pause for a two minutes..
> which hopefully gives people enough time to grab a digital camera
> to take a screenshot of the oops.

This appears to reduce the amount of information available as an oops
instead of spewing to the log and continuing generally will hang the box
stopping the scroll keys being used or dmesg being used to get the data
out. 

Who is going to wait two minutes for an oops when for most users its
their only box. Instead of pasting reports people will now reboot, or
perhaps send you the half a report they can see (which because we dump
too much info by default to fit the screen is also useless).

> The one case this doesn't catch is the problem of oopses whilst
> in X. Previously a non-fatal oops would stall X momentarily,
> and then things continue. Now those cases will lock up completely
> for two minutes. 

The console has awareness of graphic/text mode at all times and knows
what is going on. Why not use that information if you must go this way ?

Alan

