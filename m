Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265667AbSKKIMU>; Mon, 11 Nov 2002 03:12:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265668AbSKKIMU>; Mon, 11 Nov 2002 03:12:20 -0500
Received: from holomorphy.com ([66.224.33.161]:12469 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S265667AbSKKIMT>;
	Mon, 11 Nov 2002 03:12:19 -0500
Date: Mon, 11 Nov 2002 00:15:50 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Zwane Mwaikambo <zwane@holomorphy.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Mikael Pettersson <mikpe@csd.uu.se>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5] notsc option needs some attention/TLC
Message-ID: <20021111081550.GN23425@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Zwane Mwaikambo <zwane@holomorphy.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Mikael Pettersson <mikpe@csd.uu.se>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20021111012150.GO22031@holomorphy.com> <Pine.LNX.4.44.0211101747420.12703-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211101747420.12703-100000@home.transmeta.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 10, 2002 at 05:51:37PM -0800, Linus Torvalds wrote:
> But that's the point. If you specify that you have a CPU > 586, then you 
> specify at compile-time that you have TSC.
> If your TSC is broken, then you shouldn't do that. You should compile for 
> "generic x86" (386), and then say "notsc".
> (Yeah, it should work for i486 too, but in general it's the "generic 386"  
> that should work on all machines because it doesn't assume anything about
> the capabilities of the machine).
> But considering that we don't use the static TSC knowledge very much any
> more, you might want to remove CONFIG_X86_TSC altogether, though, and
> replace its uses with run-time checks. We've done that with a lot of the
> other config stuff earlier (SSE/XMM) because the static compiled options
> are just too inconvenient and not worth the maintenance hassles..

Performance considerations make compiling for 386 a relatively poor
solution. I'm very much in favor of the runtime checks and will
intensively investigate that method of dealing with the situation, and
with any luck follow up soon with a solution acceptable to both you and
others for this dynamic TSC usage issue.


Thanks,
Bill
