Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261194AbVARIuV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261194AbVARIuV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 03:50:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261189AbVARIuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 03:50:21 -0500
Received: from fw.osdl.org ([65.172.181.6]:60126 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261197AbVARIuM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 03:50:12 -0500
Date: Tue, 18 Jan 2005 00:49:35 -0800
From: Andrew Morton <akpm@osdl.org>
To: Helge Hafting <helge.hafting@hist.no>
Cc: rddunlap@osdl.org, viro@parcelfarce.linux.theplanet.co.uk, dsd@gentoo.org,
       jhf@rivenstone.net, linux-kernel@vger.kernel.org, neilb@cse.unsw.edu.au,
       opengeometry@yahoo.ca
Subject: Re: [PATCH] Wait and retry mounting root device (revised)
Message-Id: <20050118004935.7bd4a099.akpm@osdl.org>
In-Reply-To: <41ECC8AF.9020404@hist.no>
References: <20050114002352.5a038710.akpm@osdl.org>
	<20050116005930.GA2273@zion.rivenstone.net>
	<41EC7A60.9090707@gentoo.org>
	<20050118003413.GA26051@parcelfarce.linux.theplanet.co.uk>
	<41EC5207.3030003@osdl.org>
	<41ECC8AF.9020404@hist.no>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting <helge.hafting@hist.no> wrote:
>
> The USB block driver should know that 10s (or whatever) hasn't yet 
>  passed, and simply
>  block any attempt to access block devices (or scan for them) knowing 
>  that it will
>  not work yet, but any device will be there after the pause. A root mount 
>  on USB will
>  then succeed at the _first_ try everytime, so no need for retries.

Maybe a simple delay somewhere in the boot sequence would suffice?  Boot
with `mount_delay=10'.

But it sure would be nice to simply get this stuff right somehow.  If the
USB block driver knows that discovery is still in progress it should wait
until it has completed.  (I suggested that before, but wasn't 100% convinced
by the answer).
