Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264346AbTDKOsr (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 10:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262100AbTDKOsr (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 10:48:47 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:45533 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S264371AbTDKOsN (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 10:48:13 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Walt H <waltabbyh@comcast.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.20-ck5
Date: Sat, 12 Apr 2003 01:01:32 +1000
User-Agent: KMail/1.5.1
References: <3E96D711.70404@comcast.net>
In-Reply-To: <3E96D711.70404@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304120101.32423.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Apr 2003 00:54, Walt H wrote:
> Hello,
>
> I've compiled a new kernel using the ck5 patchset you made, but have had
> some problems. It seems that with my configuration, I expose a memory
> leak somewhere. After the system has been up for a while, or if I try to
> compile anything non-trivial (kde-libs for example), The system will use
> up all available memory and further memory alloc's fail. Swap is hardly
> being used in this case. My syslog file does report:

> Typically, apps fail although the OOM killer isn't triggered (not sure
> if it's enabled in ck5).

OOMK not enabled in -ck*

> I'm wondering if there's a strange interaction with XFS? I also use the
> Nvidia driver, however, I also tested without loading it and receive the
> same results. My XFS thought is due to the strange behaviour of the
> filesystem with this patchset. When I tried compiling kdelibs, the
> system chugged along until memory was used (15-20 mins) and then the
> compile could no longer proceed. After seeing this and issuing a 'sync',
> the drives thrashed for approx. 30-45 seconds as if flushing unwritten
> data. It's as if writes are being stored indefinitely? Reverting back to
> ck4 and all is well. System info below:

XFS must be responsible. I can't test it fully myself but it appears to be 
related to the latest xfs update I've included in -ck5 which is a snapshot 
from the sgi website only a week old. Until further notice, use ck4 if you 
wish to use XFS.

Thanks for the feedback.

Con
