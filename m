Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129821AbQKPIrl>; Thu, 16 Nov 2000 03:47:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129778AbQKPIra>; Thu, 16 Nov 2000 03:47:30 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:9424 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S129821AbQKPIrS>; Thu, 16 Nov 2000 03:47:18 -0500
From: Christoph Rohland <cr@sap.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: shm swapping in 2.4 again
In-Reply-To: <Pine.LNX.4.21.0011151854150.1111-100000@duckman.distro.conectiva>
Organisation: SAP LinuxLab
Date: 16 Nov 2000 09:17:03 +0100
In-Reply-To: Rik van Riel's message of "Wed, 15 Nov 2000 19:04:13 -0200 (BRDT)"
Message-ID: <qww1ywcz5z4.fsf@sap.com>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rik,

On Wed, 15 Nov 2000, Rik van Riel wrote:
> On 15 Nov 2000, Christoph Rohland wrote:
> You really want to have it in the swap cache, so we have
> a place for it allocated in cache, etc...
> 
> Basically, when we unmap it in try_to_swap_out(), we
> should add the page to the swap cache, and when the
> last user stops using the page, we should push the
> page out to swap.

So in shm_swap_out I check if the page is already in the swap
cache. If not I put the page into it and note the swap entry in the
shadow pte of shm. Right?

So does the page live all the time in the swap cache? This would lead
to a vastly increased swap usage since we would have to preallocate
the swap entries on page allocation.

Greetings
		Christoph

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
