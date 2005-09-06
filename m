Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750815AbVIFT0k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815AbVIFT0k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 15:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750820AbVIFT0k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 15:26:40 -0400
Received: from hera.kernel.org ([209.128.68.125]:45235 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1750815AbVIFT0k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 15:26:40 -0400
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: wakeup on lan enable without compiling as module
Date: Tue, 6 Sep 2005 12:26:53 -0700
Organization: OSDL
Message-ID: <20050906122653.0a2efe69@dxpl.pdx.osdl.net>
References: <20050906185338.GJ26445@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1126034793 27601 10.8.0.74 (6 Sep 2005 19:26:33 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Tue, 6 Sep 2005 19:26:33 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 1.9.13 (GTK+ 2.6.7; x86_64-redhat-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Sep 2005 20:53:38 +0200
Thomas Glanzmann <sithglan@stud.uni-erlangen.de> wrote:

> Hello,
> I would like to build the 3c59x vortex module into the kernel (not as
> module) but don't loose the ability to use wakeup-on-lan. Because it
> seems to be impossible to specify 'module parameters' to a built-in
> kernel module I tried the following patch, which doesn't work for me.
> Could someone enlighten me how I can get the expected behaviour?
> 
> Thanks,
> 	Thomas

Use
	3c59x.enable_wol on command line to pass parameters even if
	builtin.

The current practice is to use ethtool instead of module parameters to
do this. This driver doesn't support wake on lan settings via ethtool,
that would be the right way to fix.
