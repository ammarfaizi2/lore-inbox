Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129084AbRBQM0w>; Sat, 17 Feb 2001 07:26:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129136AbRBQM0n>; Sat, 17 Feb 2001 07:26:43 -0500
Received: from colorfullife.com ([216.156.138.34]:2577 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S129084AbRBQM00>;
	Sat, 17 Feb 2001 07:26:26 -0500
Message-ID: <3A8E6E0C.2F205328@colorfullife.com>
Date: Sat, 17 Feb 2001 13:26:52 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17-14 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Paul Gortmaker <p_gortmaker@yahoo.com>
CC: linux-kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] a more efficient BUG() macro
In-Reply-To: <3A8E3BA5.4B98E94E@yahoo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Gortmaker wrote:
> 
> Anyway this small patch makes sure there is only one "kernel BUG..." string,
> and dumps __FILE__ in favour of an address value since System.map data is
> needed to make full use of the BUG() dump anyways.  The memory stats of two
> otherwise identical kernels:
>

Shouldn't the linker drop duplicate strings?

info gcc mentions that gcc merges duplicate strings, but it seems that
it doesn't work (gcc-2.96-69, binutils-2.10.0.18-1).

--
	Manfred
