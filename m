Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751488AbWEJPj5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751488AbWEJPj5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 11:39:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751465AbWEJPj5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 11:39:57 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:61161 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S1751488AbWEJPj5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 11:39:57 -0400
Date: Wed, 10 May 2006 11:39:50 -0400
To: Carlos Ojea Castro <nuudoo.fb@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: LPC bus in a geode sc1200
Message-ID: <20060510153950.GE2835@csclub.uwaterloo.ca>
References: <bae323a50605090211t6af09c75u7cab1aac71e0e412@mail.gmail.com> <20060509142851.GA2837@csclub.uwaterloo.ca> <bae323a50605100055q7fbe9470q889874316348c2c3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bae323a50605100055q7fbe9470q889874316348c2c3@mail.gmail.com>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2006 at 09:55:47AM +0200, Carlos Ojea Castro wrote:
> Thank you very much for your reply, Len.
> I will also have an FPGA (I think it will be on port 0x1400 or so). I
> am writing to LPC using 'outb' like this: outb (data, port);
> So I see an I/O write on the LPC bus, that is: 2 bytes for address and
> 1 byte for data (it tooks one microsecond per transfer).
> 
> To speed up things, I wish to transmit more than 1 byte for data in
> each transfer (if possible).
> Accordingly with page 194 of the sc1200 processor data book, it is
> also possible to do a "Bus Master Memory Write" to transmit 1,2 or 4
> bytes.
> Do you know how can I make a "Bus Master Memory Write" to the LPC?

Well I know we don't do that.  We have very little data, just board
status information from various places on the board.  LPC does support
doing DMA, which I believe is done in the same way it was done on ISA at
least as far as the software is concerned.  How to implement DMA for LPC
in the FPGA I have no idea.  The LPC specifications would probably tell
you.  I imagine it involves setting up a DMA buffer in RAM (in the first
16MB probably) and then sending a command to the FPGA telling it to do a
DMA transfer from that memory location using the LPC DMA commands.

Len Sorensen
