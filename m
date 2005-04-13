Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261333AbVDMNDs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261333AbVDMNDs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 09:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261334AbVDMNC4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 09:02:56 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:25827 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S261333AbVDMNCd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 09:02:33 -0400
Date: Wed, 13 Apr 2005 09:02:30 -0400
To: John M Collins <jmc@xisl.com>
Cc: Chris Wright <chrisw@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Exploit in 2.6 kernels
Message-ID: <20050413130230.GO17865@csclub.uwaterloo.ca>
References: <1113298455.16274.72.camel@caveman.xisl.com> <425BBDF9.9020903@ev-en.org> <1113318034.3105.46.camel@caveman.xisl.com> <20050412210857.GT11199@shell0.pdx.osdl.net> <1113341579.3105.63.camel@caveman.xisl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1113341579.3105.63.camel@caveman.xisl.com>
User-Agent: Mutt/1.3.28i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2005 at 10:32:59PM +0100, John M Collins wrote:
> I'll do that - trouble is round where I am they dish out Nvidia cards
> like confetti, I've got them in the machine I use most and another 2 and
> you have to do all that gyrating with running the script to FTP down and
> build the secret module before you can run X. This is a big disincentive
> when it comes to installing new kernels.
> 
> I wish some kind soul would speak nicely to Nvidia and get them to see
> reason on the point but I suspect I'm not the first person to wish that.
> (Or is there a sneaky way of patching the modules so they'll work in
> another kernel without tainting it?).

Well on my ssytem I can do something as simple as this in a script at
boot (before starting X) and it should nicely take care of it:

modprobe nvidia || m-a -t prepare nvidia && m-a -t build nvidia && m-a -t install nvidia && modprobe nvidia

Most likely I will have a working loaded nvidia driver at that point and
X will start successfully.

m-a is module-assistant which is used on debian to build a module
mathcing the running kernel (assuming it has access to either the source
of the running kernel or the headers of the running kernel) using the
sources from in this case nvidia-kernel-source package.  I don't know if
anything other than debian has anything like this, but it makes dealing
with nvidia's binary drivers fairly tolerable.

Len Sorensen
