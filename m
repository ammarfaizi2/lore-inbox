Return-Path: <linux-kernel-owner+w=401wt.eu-S932762AbXABKSe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932762AbXABKSe (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 05:18:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932740AbXABKSe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 05:18:34 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:58342 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932732AbXABKSd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 05:18:33 -0500
Date: Tue, 2 Jan 2007 10:28:29 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Jeremy Higdon <jeremy@sgi.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] cdrom: longer timeout for "Read Track Info" command
Message-ID: <20070102102829.4117b230@localhost.localdomain>
In-Reply-To: <20070102023623.GA3108@sgi.com>
References: <20070102023623.GA3108@sgi.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Jan 2007 18:36:24 -0800
Jeremy Higdon <jeremy@sgi.com> wrote:

> I have a DVD combo drive and a CD in which the
> "READ TRACK INFORMATION" command (implemented in the
> cdrom_get_track_info() function) takes about 7 seconds to run.
> The current implementation of cdrom_get_track_info() uses the
> default timeout of 5 seconds.  So here's a patch that increases
> the timeout from 5 to 15 seconds.
> 
> The drive in question is a TSSTcorpCD/DVDW SN-S082D, and I have
> a Silicon Image 680A adapter, in case that's of interest.
> 
> signed-off-by: <jeremy@sgi.com>

Please test with a seven second timeout rather than fifteen which is way
longer than anyone wants to wait. Seven is the magic value used by
another major vendor so ought to be right for all hardware 8)
