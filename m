Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280841AbRKBV2W>; Fri, 2 Nov 2001 16:28:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280847AbRKBV2N>; Fri, 2 Nov 2001 16:28:13 -0500
Received: from ns.ithnet.com ([217.64.64.10]:55567 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S280841AbRKBV2C>;
	Fri, 2 Nov 2001 16:28:02 -0500
Date: Fri, 2 Nov 2001 22:27:54 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: phillips@bonn-fries.net
Subject: Re: Google's mm problem - not reproduced on 2.4.13
Message-Id: <20011102222754.2366f1f5.skraw@ithnet.com>
In-Reply-To: <Pine.LNX.4.33.0111021303060.20128-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0111021250560.20078-100000@penguin.transmeta.com>
	<Pine.LNX.4.33.0111021303060.20128-100000@penguin.transmeta.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Nov 2001 13:13:10 -0800 (PST) Linus Torvalds <torvalds@transmeta.com>
wrote:

> -	/* Don't swap out areas which are locked down */
> -	if (vma->vm_flags & (VM_LOCKED|VM_RESERVED))
> +	/* Don't swap out areas which are reserved */
> +	if (vma->vm_flags & VM_RESERVED)
>  		return count;

Although I agree what you said about differences of old and new VM, I believe
the above was not really what Ben intended to do by mlocking. I mean, you swap
them out right now, or not?

Regards,
Stephan

