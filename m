Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280043AbRKRV0P>; Sun, 18 Nov 2001 16:26:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280083AbRKRV0E>; Sun, 18 Nov 2001 16:26:04 -0500
Received: from mauve.csi.cam.ac.uk ([131.111.8.38]:64473 "EHLO
	mauve.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S280043AbRKRVZt>; Sun, 18 Nov 2001 16:25:49 -0500
Content-Type: text/plain; charset=US-ASCII
From: James A Sutherland <jas88@cam.ac.uk>
To: war <war@starband.net>, linux-kernel@vger.kernel.org
Subject: Re: Swap
Date: Sun, 18 Nov 2001 21:25:50 +0000
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <3BF82443.5D3E2E11@starband.net>
In-Reply-To: <3BF82443.5D3E2E11@starband.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E165ZRi-000718-00@mauve.csi.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 18 November 2001 9:12 pm, war wrote:
> It is amazing that I could run all of that stuff, because:
>
> When I have swap on, and if I run all of those programs, 200-400MB of
> swap is used.

Yep. There's a reason for that: the kernel is *ALWAYS* able to swap pages out 
to disk - even without "swap space". Disabling swapspace simply forces the 
kernel to swap out more code, since it cannot swap out any data.

(This is why you can still get "disk thrashing" without any swap - in fact, 
it's more likely in this case than it is with some swap added - you are just 
forcing your binaries to take more of the swapping load instead.)


So: with swapspace, the kernel swaps out a few hundred Mb of unused data, to 
make room for more code. Without it, the kernel is forced to swap out code 
pages instead. The big news here is...?


James.
