Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262932AbUJ0W2N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262932AbUJ0W2N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 18:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262904AbUJ0WZR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 18:25:17 -0400
Received: from lucidpixels.com ([66.45.37.187]:58052 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id S262934AbUJ0WXy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 18:23:54 -0400
Date: Wed, 27 Oct 2004 18:23:52 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p500
To: Francois Romieu <romieu@fr.zoreil.com>
cc: Andrew Morton <akpm@osdl.org>, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.9 Multiple Page Allocation Failures (Part 2)
In-Reply-To: <20041027221941.GA20196@electric-eye.fr.zoreil.com>
Message-ID: <Pine.LNX.4.61.0410271823410.10927@p500>
References: <Pine.LNX.4.61.0410250645540.9868@p500> <417CE49B.4060308@yahoo.com.au>
 <Pine.LNX.4.61.0410271733440.10927@p500> <20041027145806.4e7acea3.akpm@osdl.org>
 <Pine.LNX.4.61.0410271754280.10927@p500> <20041027221941.GA20196@electric-eye.fr.zoreil.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ah, you are correct:

root@p500:~# ethtool -k eth0
Offload parameters for eth0:
rx-checksumming: on
tx-checksumming: on
scatter-gather: on
tcp segmentation offload: on
root@p500:~# ethtool -k eth1
Offload parameters for eth1:
Cannot get device rx csum settings: Operation not supported
Cannot get device tx csum settings: Operation not supported
Cannot get device scatter-gather settings: Operation not supported
Cannot get device tcp segmentation offload settings: Operation not 
supported
no offload info available
root@p500:~# ethtool -k eth2
Offload parameters for eth2:
Cannot get device rx csum settings: Operation not supported
Cannot get device tx csum settings: Operation not supported
Cannot get device scatter-gather settings: Operation not supported
Cannot get device tcp segmentation offload settings: Operation not 
supported
no offload info available
root@p500:~# ethtool -k eth3
Offload parameters for eth3:
Cannot get device rx csum settings: Operation not supported
Cannot get device tx csum settings: Operation not supported
Cannot get device scatter-gather settings: Operation not supported
Cannot get device tcp segmentation offload settings: Operation not 
supported
no offload info available
root@p500:~#


On Thu, 28 Oct 2004, Francois Romieu wrote:

> Justin Piszcz <jpiszcz@lucidpixels.com> :
> [...]
>> I do not explicitly set ethtool* tso, however I use dhcpcd on this
>> interface, does that set TSO on the interface? I have never used TSO (that
>
> Hint: ethtool -k ethX
>
> --
> Ueimor
>
