Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266615AbUGPRdy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266615AbUGPRdy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 13:33:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266616AbUGPRdy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 13:33:54 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:12525 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S266615AbUGPRdx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 13:33:53 -0400
Date: Fri, 16 Jul 2004 14:08:12 -0400
From: Adam Kropelin <akropel1@rochester.rr.com>
To: Brian McEntire <brianm@fsg1.nws.noaa.gov>
Cc: kaos@ocs.com.au, linux-kernel@vger.kernel.org, akpm@zip.com.au,
       jgarzik@pobox.com, netdev@oss.sgi.com
Subject: Re: Suggestions with hard lockup on 4 systems, have oops report
Message-ID: <20040716140812.A8270@mail.kroptech.com>
References: <Pine.LNX.4.44.0407161025030.20914-200000@fsg1.nws.noaa.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0407161025030.20914-200000@fsg1.nws.noaa.gov>; from brianm@fsg1.nws.noaa.gov on Fri, Jul 16, 2004 at 11:01:39AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 16, 2004 at 11:01:39AM -0400, Brian McEntire wrote:
> Thank you for taking time from your busy days to read this. You all
> (kernel maintainers) rock!  :)
> 
> I have four Linux hosts, with identical hardware and OSs, that exhibit a
> very tough to troubleshoot hang/freeze.  About once every two weeks (and

<snip>

> The OS specifics:
>   RH 7.2 with latest patches except running kernel 2.4.9-31enterprise for 
> CM reasons (at one point, I tried the latest available RH 7.2 kernel but 
> it did not improve stability so I went back.)
>  bcm5700-7.1.22-1
>  nvidia ??  (no RPM listed, didn't know where to find the version.)

You've really got to eliminate the binary bcm5700 and nvidia modules in
order to diagnose this. Based on the oops, bcm5700 looks suspect, but it
could just be the unlucky guy whose memory was stepped on by nvidia or
some other part of the kernel.

Switch to an open NIC like e1000 temporarily (or better yet,
permanently) and see if the lockup persists. Do the same with nvidia. If
you can reproduce the problem without ever having loaded either module
(unloading the module once it's loaded is not sufficient), post the new
oops and you'll have a solid foundation for debugging.

--Adam

