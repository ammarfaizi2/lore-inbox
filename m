Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261764AbTKCNrH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 08:47:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261772AbTKCNrH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 08:47:07 -0500
Received: from tweedy.ksc.nasa.gov ([128.217.76.165]:24034 "EHLO
	tweedy.ksc.nasa.gov") by vger.kernel.org with ESMTP id S261764AbTKCNrF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 08:47:05 -0500
Subject: Re: initrd help -- umounts root after pivot_root
From: Bob Chiodini <robert.chiodini-1@ksc.nasa.gov>
To: "H. Peter Anvin" <hpa@transmeta.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <bnulvd$fps$1@cesium.transmeta.com>
References: <1067604362.5526.15.camel@tweedy.ksc.nasa.gov>
	 <bnulvd$fps$1@cesium.transmeta.com>
Content-Type: text/plain
Message-Id: <1067867220.5526.55.camel@tweedy.ksc.nasa.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 03 Nov 2003 08:47:00 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-10-31 at 16:59, H. Peter Anvin wrote:
> 	From: H. Peter Anvin <hpa@zytor.com>
> MIME-Version: 1.0
> Content-Type: text/plain; charset=ISO-8859-1
> Content-Transfer-Encoding: 8bit
> X-Comment-To: Bob Chiodini <robert.chiodini-1@ksc.nasa.gov>
> Disclaimer: Not speaking for Transmeta in any way, shape, or form.
> Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
> 
> Followup to:  <1067604362.5526.15.camel@tweedy.ksc.nasa.gov>
> By author:    Bob Chiodini <robert.chiodini-1@ksc.nasa.gov>
> In newsgroup: linux.dev.kernel
> > 
> > John,
> > 
> > It does not appear that the kernel(s) will support the root fs on
> > tmpfs.  Looking through the init kernel code:  It boils down to a block
> > device with real major and minor number or NFS.
> > 
> 
> Baloney.  See the SuperRescue CD, for example, for a distro which uses
> exactly this.
> 
> 	-hpa

I stand corrected.  I should have been clearer making this statement.  I
did not see a mechanism for mounting a tmpfs in do_mounts.c, or main.c. 
One question:  I see that superrescue execs init and the end of
linuxrc.  Does this cause the kernel initialization to yield in
handle_initrd(), until init exits (reboot/shutdown)?

Bob... 

