Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932574AbVI3HNg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932574AbVI3HNg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 03:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932572AbVI3HNg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 03:13:36 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27869 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932571AbVI3HNf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 03:13:35 -0400
Date: Fri, 30 Sep 2005 00:13:01 -0700
From: Andrew Morton <akpm@osdl.org>
To: dth@cistron.nl (Danny ter Haar)
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: 2.6.14-rc2-git7 crashed on amd64 (usenet gateway) after 18
 hours
Message-Id: <20050930001301.08eeab9d.akpm@osdl.org>
In-Reply-To: <dhinf5$skf$1@news.cistron.nl>
References: <dhinf5$skf$1@news.cistron.nl>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dth@cistron.nl (Danny ter Haar) wrote:
>
> Known story:
> last stable kernel for this machine is/was 2.6.12-mm1
> 
> Every 2.6.1[34] kernel panics so far.
> Sometimes after 40 minutes, sometimes after 4 days.
> 
> Config/more info at:
> http://newsgate.newsserver.nl/kernel/2.6.14-rc2-git7/

The aic79xx driver shat itself.

The log buffer starts with

scsi1 (4:0): rejecting I/O to offline device
scsi1 (4:0): rejecting I/O to offline device
scsi1 (4:0): rejecting I/O to offline device

So we've probably lost the info which will tell us how the problems
started.  A serial console would be nice.

> This time it was scsi system again which "blew-up"
> 
> Obvious difference i see between 2.6.12 en 2.6.1[34] is that the 
> scsi/ethernet cards have different IRQ's set. 
> If i'm correct acpi code changed in 2.6.13, right ?
> 
> Since the 2.6.12-mm1 kernel survived 3 weeks+ and gave super performance
> i'm convinced it's not a hardware issue.
> 
> Just giving feedback.
> 
> Will try git8 and mm2 and of course report here when they fail.

Are all the failures due to the aic79xx driver failing in this manner?  If
not then please report the different failures separately, thanks.
