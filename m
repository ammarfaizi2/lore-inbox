Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265073AbUEUXCk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265073AbUEUXCk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 19:02:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265345AbUEUWly
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 18:41:54 -0400
Received: from sabe.cs.wisc.edu ([128.105.6.20]:3086 "EHLO sabe.cs.wisc.edu")
	by vger.kernel.org with ESMTP id S266033AbUEUWdD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 18:33:03 -0400
Message-ID: <40AD21CC.9050108@cs.wisc.edu>
Date: Thu, 20 May 2004 16:23:24 -0500
From: Alexander Mirgorodskiy <mirg@cs.wisc.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: apm standby on thinkpad
References: <40AB65B3.2070102@cs.wisc.edu> <1085076978.3121.12.camel@leatherman>
In-Reply-To: <1085076978.3121.12.camel@leatherman>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Just for a datapoint, I cannot reproduce the issue using 2.6.6 on a T40
> installed with Fedora Core 1.

Thank you for checking, it made me try 2.6.6 and I still see the same 
problem.

The good news is, the problem does not happen on a virtual console, only 
in X. In fact, I narrowed it down to radeon_drv.o in X11 from RedHat 9. 
After replacing just that file with the one from a recent Debian 
machine, the problem went away.

Both modules report the same version (4.0.1), but were compiled for 
slightly different X distributions (4.3.0 in RedHat vs 4.3.0.1 in Debian).

Alex

