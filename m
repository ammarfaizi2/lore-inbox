Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281461AbRKTXBV>; Tue, 20 Nov 2001 18:01:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281464AbRKTXBN>; Tue, 20 Nov 2001 18:01:13 -0500
Received: from att-lp2.wirelessmatrixcorp.com ([66.46.106.131]:50565 "HELO
	wirelessmatrixcorp.com") by vger.kernel.org with SMTP
	id <S281462AbRKTXAC>; Tue, 20 Nov 2001 18:00:02 -0500
Date: Tue, 20 Nov 2001 15:59:56 -0700
From: Bill Currie <billc@wirelessmatrixcorp.com>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, lnz@dandelion.com
Subject: Re: DAC960 oops
Message-ID: <20011120155955.E15561@wirelessmatrixcorp.com>
In-Reply-To: <20011119114446.A15561@wirelessmatrixcorp.com> <20011120200144.W31820@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011120200144.W31820@suse.de>; from axboe@suse.de on Tue, Nov 20, 2001 at 08:01:44PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2001 at 08:01:44PM +0100, Jens Axboe wrote:
> On Mon, Nov 19 2001, Bill Currie wrote:
> > I'm trying to get a DS20 with a Mylex DAC960 up-and-running (boots just fine
> > off the ide drive:) but when I modprobe DAC960, I get the following oops
> > (while ksymoops is moaning about symbols etc, I got the symbols from the exact
> > kernel running (infact, I think it's /still/ running:)):
> 
> DAC960 calls blk_cleanup_queue on a un-initialized queue, tell Leonard.

Thanks, and I'll try to do that once I've got things sorted (I discovered the
root cause of the problem was unsupported firmware version, though the oops is
unacceptable anyway:).

My current problem is finding out whether I can just pop in new roms with the
3.51 firmware and still have the DEC SRM software still work
(KZPSC-UX/KZPAC-XF). The needed sockets are there on the main board but that
doesn't mean the DEC firmware will work with 3.51 (the current firmware is
2.49).
