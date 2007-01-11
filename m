Return-Path: <linux-kernel-owner+w=401wt.eu-S932108AbXAKWWt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108AbXAKWWt (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 17:22:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932657AbXAKWWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 17:22:48 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:55024 "EHLO outpost.ds9a.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932108AbXAKWWs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 17:22:48 -0500
Date: Thu, 11 Jan 2007 23:22:46 +0100
From: bert hubert <bert.hubert@netherlabs.nl>
To: Sean Reifschneider <jafo@tummy.com>
Cc: David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org
Subject: Re: select() setting ERESTARTNOHAND (514).
Message-ID: <20070111222246.GA27976@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <bert.hubert@netherlabs.nl>,
	Sean Reifschneider <jafo@tummy.com>,
	David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org
References: <20070110234238.GB10791@tummy.com> <20070110.162747.28789587.davem@davemloft.net> <20070111010429.GN7121@tummy.com> <20070110.171520.23015257.davem@davemloft.net> <20070111082516.GU7121@tummy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070111082516.GU7121@tummy.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 11, 2007 at 01:25:16AM -0700, Sean Reifschneider wrote:

> Nope, I haven't looked in strace at all.  It's definitely making it to
> user-space.  The code in question is (abbreviated):
> 
>    if (select(0, (fd_set *)0, (fd_set *)0, (fd_set *)0, &t) != 0) {
>       PyErr_SetFromErrno(PyExc_IOError);
>       return -1;
>       }

Anything else relevant? Do you know which signal interrupted select? Is this
a single or multithreaded application? And where did the signal come from?

I tried to reproduce your problem in various ways on 2.6.20-rc4, but it
didn't appear.

Thanks.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://netherlabs.nl              Open and Closed source services
