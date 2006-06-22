Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161090AbWFVLtz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161090AbWFVLtz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 07:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161088AbWFVLtz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 07:49:55 -0400
Received: from baldrick.bootc.net ([83.142.228.48]:17351 "EHLO
	baldrick.fusednetworks.co.uk") by vger.kernel.org with ESMTP
	id S1161086AbWFVLty (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 07:49:54 -0400
Message-ID: <449A83DE.9090902@bootc.net>
Date: Thu, 22 Jun 2006 12:49:50 +0100
From: Chris Boot <bootc@bootc.net>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: daveflinux@aim.com
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: Dropped TCP connections with 2.6.X kernel
References: <7fc623d50606192355l799ea043hc4eacb190e6be1ce@mail.gmail.com> <1150791472.2891.164.camel@laptopd505.fenrus.org> <8C8631AA59959A1-528-3CB0@FWM-D36.sysops.aol.com> <8C863E49608F8CC-184C-2F8D@FWM-D28.sysops.aol.com>
In-Reply-To: <8C863E49608F8CC-184C-2F8D@FWM-D28.sysops.aol.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

daveflinux@aim.com wrote:
> Hi,
>
> We're using a 2.6.X kernel,
>  and are experiencing intermittent dropped connections when the number 
> of concurrent connections exceeds ~ 1000.
>
>  Does anybody have any insight into what might be happening here 
> and/or troubleshooting techniques
> for isolating the problem.
> What system resources is TCP dependent on?
>
> Many thanks,
> Dave

Are all these connections handled by a single process? If so, you're 
probably running into the limit of open file descriptors (1024 usually). 
Look at 'help ulimit' to see how to increase the limit.

HTH,
Chris

