Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751133AbWEXQ7a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133AbWEXQ7a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 12:59:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbWEXQ7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 12:59:30 -0400
Received: from mpc-26.sohonet.co.uk ([193.203.82.251]:3505 "EHLO
	moving-picture.com") by vger.kernel.org with ESMTP id S1751133AbWEXQ73
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 12:59:29 -0400
Message-ID: <447490EF.8010000@moving-picture.com>
Date: Wed, 24 May 2006 17:59:27 +0100
From: James Pearson <james-p@moving-picture.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040524
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 4096 byte limit to /proc/PID/environ ?
References: <447481C0.5050709@moving-picture.com> <Pine.LNX.4.61.0605241235110.2450@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0605241235110.2450@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Disclaimer: This email and any attachments are confidential, may be legally
X-Disclaimer: privileged and intended solely for the use of addressee. If you
X-Disclaimer: are not the intended recipient of this message, any disclosure,
X-Disclaimer: copying, distribution or any action taken in reliance on it is
X-Disclaimer: strictly prohibited and may be unlawful. If you have received
X-Disclaimer: this message in error, please notify the sender and delete all
X-Disclaimer: copies from your system.
X-Disclaimer: 
X-Disclaimer: Email may be susceptible to data corruption, interception and
X-Disclaimer: unauthorised amendment, and we do not accept liability for any
X-Disclaimer: such corruption, interception or amendment or the consequences
X-Disclaimer: thereof.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os (Dick Johnson) wrote:
> On Wed, 24 May 2006, James Pearson wrote:
> 
> 
>>It appears that /proc/PID/environ only returns the first 4096 bytes of a
>>processes' environment.
>>
>>Is there any other way via userland to get the whole environment for a
>>process?
>>
>>Thanks
>>
>>James Pearson
> 
> 
> 
> I think that /proc/PID/environ just returns the environment that
> existed when the process was created, irrespective of size. You
> can check this as:
> 
> #include <stdio.h>
> 
> main()
> {
>      setenv("FOO=", "1234", 1);
>      printf("%d\n", getpid());
>      pause();
> }
> 
> Variable "FOO" will not appear in /proc. It you set the environment
> in non-standard ways, overwriting the original, you can see it in
> /proc.

I'm not worried about that - more the fact that when I do:

% cat /proc/$$/environ | wc -c
4096
% env | wc -c
7329

/proc/PID/environ is truncated ...

James Pearson
