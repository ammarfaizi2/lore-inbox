Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261171AbVCGOfv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261171AbVCGOfv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 09:35:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261187AbVCGOfv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 09:35:51 -0500
Received: from www.rapidforum.com ([80.237.244.2]:42390 "HELO rapidforum.com")
	by vger.kernel.org with SMTP id S261171AbVCGOfp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 09:35:45 -0500
Message-ID: <422C66B8.2060605@rapidforum.com>
Date: Mon, 07 Mar 2005 15:35:36 +0100
From: Christian Schmid <webmaster@rapidforum.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a3) Gecko/20040817
X-Accept-Language: de, en
MIME-Version: 1.0
To: Ben Greear <greearb@candelatech.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: BUG: Slowdown on 3000 socket-machines tracked down
References: <4229E805.3050105@rapidforum.com> <422BAAC6.6040705@candelatech.com> <422BB548.1020906@rapidforum.com> <422BC303.9060907@candelatech.com>
In-Reply-To: <422BC303.9060907@candelatech.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Greear wrote:
>> Its a full-duplex. Its a download-service with 3000 downloaders all 
>> over the world.
> 
> 
> So actually it's really mostly one-way traffic, ie in the download 
> direction.
> Anything significant at all going upstream, other than ACKs, etc?

Not much. See on the graph. The red is the downstream ;)

>> Yes. send-buffer to 64 kbytes and receive buffer to 16 kbytes.
> 
> 
> With regard to this note in the 'man 7 socket' man page:
> 
> NOTES
>        Linux assumes that half of the send/receive buffer is used for 
> internal kernel struc-
>        tures; thus the sysctls are twice what can be observed on the wire.
> 
> What value are you using for the sockopt call?

First I used 64 * 1024 but some months ago I checked with getsockopt and realized that it always 
gives twice of the value back. So I just have done 64 * 512 ;)

Chris
