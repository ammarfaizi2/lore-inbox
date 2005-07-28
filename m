Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262080AbVG1Xcu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262080AbVG1Xcu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 19:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262107AbVG1Xcu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 19:32:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:5578 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262080AbVG1Xct (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 19:32:49 -0400
Date: Thu, 28 Jul 2005 16:31:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: 2.6.13-rc3-mm3
Message-Id: <20050728163142.3cb66228.akpm@osdl.org>
In-Reply-To: <200507282340.57905.rjw@sisk.pl>
References: <20050728025840.0596b9cb.akpm@osdl.org>
	<200507282111.32970.rjw@sisk.pl>
	<20050728121656.66845f70.akpm@osdl.org>
	<200507282340.57905.rjw@sisk.pl>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> wrote:
>
>  Could you please tell me how I can figure out the order in which the individual
>  patches in -mm have been applied?

It's all in the series file:

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc3/2.6.13-rc3-mm3/patch-series

The simplest way to do a binary search is to grab
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc3/2.6.13-rc3-mm3/2.6.13-rc3-mm3-broken-out.tar.bz2
and to place all the patches in ./patches/, place the series file in
./series, download and install https://savannah.nongnu.org/projects/quilt/
and do the binary search with `quilt push' and `quilt pop'.

It's pretty simple - it'll take ten minutes to get the hang of it.  You
need to create a separate copy of the series file and edit it to record
where you're up to in the search.  From experience ;)
