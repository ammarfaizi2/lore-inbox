Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932489AbWEaFur@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932489AbWEaFur (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 01:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932094AbWEaFur
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 01:50:47 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:36252 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S932489AbWEaFuq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 01:50:46 -0400
Message-ID: <447D2EA8.8020001@colorfullife.com>
Date: Wed, 31 May 2006 07:50:32 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.13) Gecko/20060501 Fedora/1.7.13-1.1.fc5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Willy Tarreau <willy@w.ods.org>
CC: marcelo@kvack.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Ayaz Abdulla <aabdulla@nvidia.com>
Subject: Re: [PATCH-2.4] forcedeth update to 0.50
References: <20060530220319.GA6945@w.ods.org>
In-Reply-To: <20060530220319.GA6945@w.ods.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Willy,

Willy Tarreau wrote:

>I started from the latest backport you sent in september (0.42) and
>incrementally applied 2.6 updates. I stopped at 0.50 which provides
>VLAN support, because after this one, there are some 2.4-incompatible
>changes (64bit consistent memory allocation for rings, and MSI/MSIX
>support).
>
>  
>
I agree, 2.4 needs a backport. Either a full backport as you did, or a 
minimal one-liner fix.
Right now, the driver is not usable due to an incorrect initialization.
Or to be more accurate:
    # modprobe
    # ifup
works.
But
    # modprobe
    # ifup
    # ifdown
    # ifup
causes a misconfiguration, and the nic hangs hard after a few MB. And 
recent distros do the equivalent of ifup/ifdown/ifup somewhere in the 
initialization.

Marcelo: Do you need a one-liner, or could you apply a large backport patch?

--
    Manfred
