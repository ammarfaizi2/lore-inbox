Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290635AbSBLAWm>; Mon, 11 Feb 2002 19:22:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290636AbSBLAWW>; Mon, 11 Feb 2002 19:22:22 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:53004 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S290635AbSBLAWJ>; Mon, 11 Feb 2002 19:22:09 -0500
Message-ID: <3C68602E.91D12F2F@linux-m68k.org>
Date: Tue, 12 Feb 2002 01:22:06 +0100
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Howells <dhowells@redhat.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: thread_info implementation
In-Reply-To: <22351.1013472622@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

David Howells wrote:

> Why are you using bitfield instructions on the m68k arch? why not use just
> simple bit instructions (or and/or/xor where masking)? All the flags are
> single bit width fields.

These are two bytes longer as well, right now I'm doing this:

        tstw    %d0
        jeq     do_signal_return
        tstb    %d0
        jne     do_delayed_trace

using btst or andw this would be four bytes longer.

bye, Roman
