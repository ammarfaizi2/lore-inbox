Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261798AbULVOyk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261798AbULVOyk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 09:54:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261835AbULVOyh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 09:54:37 -0500
Received: from mproxy.gmail.com ([216.239.56.240]:6699 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261775AbULVOyZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 09:54:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=ufVDwfErfSEo6TZwIqEj2VF5WNbet7N+FLz7jRUEZTNdVKAx+aSMOzYz+zPPubVQxGPKZwaVUDej6Q1TwhlylZLBR7N6VZbXntDoiJpg7eHAMwuTlK6wnD4CnavZMrOr40xzxY/m1v7kh1QuOCAFn0B7P8AUerb2bmt4M9eikC4=
Message-ID: <892457750412220654918c785@mail.gmail.com>
Date: Wed, 22 Dec 2004 08:54:24 -0600
From: Jon Mason <jdmason@gmail.com>
Reply-To: Jon Mason <jdmason@gmail.com>
To: Richard Ems <richard.ems@mtg-marinetechnik.de>
Subject: Re: PROBLEM: Network hang: "eth0: Tx timed out (f0080), is buffer full?"
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
In-Reply-To: <41C93E93.5070704@mtg-marinetechnik.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200412171100.16601.richard.ems@mtg-marinetechnik.de>
	 <8924577504121710054331bb54@mail.gmail.com>
	 <8924577504121712527144a5cf@mail.gmail.com>
	 <41C6E2E1.8030801@mtg-marinetechnik.de>
	 <8924577504122009126c40c1fe@mail.gmail.com>
	 <41C713EF.8050003@mtg-marinetechnik.de>
	 <892457750412201231461415a1@mail.gmail.com>
	 <41C7F204.3030503@mtg-marinetechnik.de>
	 <89245775041221080238187402@mail.gmail.com>
	 <41C93E93.5070704@mtg-marinetechnik.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard,
Yes, I need the tx timeout lines.  Those tell me if the patch was
successfull in solving the interrupt enablement issue.  From your
statement below, it appears that it was either unsucessful (and you
didn't wait long enough for it to timeout) or the root problem lies
somewhere else.

Please give it a good 20 minutes (if you can get away with it being
down for that long) to timeout, as it has been taking 5-10 minutes in
your previous errors.  There is no set timeframe for it to timeout. 
It will only timeout after netif_stop_queue has true for a minute.  if
this never happens, then it leads me to believe that the adapter is
still functioning.  I know you can't log in to the system because of
the nfs mounts, but can you see if the system is pingable before you
reboot it?

Thanks,
Jon

On Wed, 22 Dec 2004 10:29:55 +0100, Richard Ems
<richard.ems@mtg-marinetechnik.de> wrote:
> Jon, thanks for the last patch, it applied without errors or warnings.
> But the NIC is still hanging.
> Here the last hang data. Do you need the "Tx timed out" lines? I
> apparently didn't wait long enough for this timeout to trigger ...
> Is it a 5 min timeout?
> 
> Dec 22 10:00:37 urutu kernel: eth0: HostError! IntStatus 0082. 216 59
> 248001a0 7c2
> Dec 22 10:02:24 urutu kernel: nfs: server jupiter not responding, still
> trying
> Dec 22 10:02:55 urutu last message repeated 7 times
> Dec 22 10:03:52 urutu last message repeated 3 times
> Dec 22 10:04:14 urutu kernel: nfs: server jupiter not responding, still
> trying
> Dec 22 10:06:07 urutu syslogd 1.4.1: restart.
