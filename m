Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282818AbRLRPeF>; Tue, 18 Dec 2001 10:34:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282547AbRLRPd4>; Tue, 18 Dec 2001 10:33:56 -0500
Received: from sun.fadata.bg ([80.72.64.67]:38151 "HELO fadata.bg")
	by vger.kernel.org with SMTP id <S283626AbRLRPdj> convert rfc822-to-8bit;
	Tue, 18 Dec 2001 10:33:39 -0500
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Loopback deadlock again
In-Reply-To: <Pine.LNX.4.33.0112180410220.421-100000@fargo>
From: Momchil Velikov <velco@fadata.bg>
In-Reply-To: <Pine.LNX.4.33.0112180410220.421-100000@fargo>
Date: 18 Dec 2001 17:31:19 +0200
Message-ID: <87y9k0bl4o.fsf@fadata.bg>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(sorry for posting twice, but you mail bounced)

>>>>> "David" == David Gómez <davidge@jazzfree.com> writes:

David> On Mon, 17 Dec 2001, Marcelo Tosatti wrote:
>> 
>> Get the backtrace of the loopback thread (using magic sysrq) and use
>> ksymoops to decode it using the System.map of your running kernel...

David> Trace; c01304f8 <__wait_on_buffer+68/90>
David> Trace; c0131d69 <__block_prepare_write+239/260>
David> Trace; c012ac61 <__alloc_pages+41/180>
David> Trace; c0132271 <block_prepare_write+21/40>
David> Trace; c014e260 <ext2_get_block+0/410>
David> Trace; e08522df <[loop]lo_send+df/1e0>
David> Trace; e08522df <[loop]lo_send+df/1e0>

Can you recompile without -fomit-frame-pointer ? The back trace
doesn't look right.

Regards,
-velco


