Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964793AbWEJHzv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964793AbWEJHzv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 03:55:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964843AbWEJHzv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 03:55:51 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:37599 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932318AbWEJHzu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 03:55:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=almMubvhKchP/SE0z19yufKvsi1XPIi5WyV7LV9Keyw8037Uk2iZaTp0hyFZit86mQBUOZZxPbfhne9CWMISQoQtu+DEwiYit49t153yUvSeFSmxBf4z6Xkyl3qnV5IaLqYjoxeOe9HimoceZmOKiFTSoPz8fXDhRfqPduzfw4A=
Message-ID: <bae323a50605100055q7fbe9470q889874316348c2c3@mail.gmail.com>
Date: Wed, 10 May 2006 09:55:47 +0200
From: "Carlos Ojea Castro" <nuudoo.fb@gmail.com>
To: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Subject: Re: LPC bus in a geode sc1200
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060509142851.GA2837@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <bae323a50605090211t6af09c75u7cab1aac71e0e412@mail.gmail.com>
	 <20060509142851.GA2837@csclub.uwaterloo.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I wrote a driver to use LPC bus in a geode sc1200. For now I am able
> > to transmit an read or write "I/O cycle" to the LPC.
> > What I want to do now is to read or write to the LPC using a "Memory
> cycle".
> >
> > Anyone knows how can I archieve this?
> > is there another list more suitable for my question?
>
> The LPC bus is the same as ISA as far as software is concerned.  You
> just read and write to it, or do DMA or whatever you want.
>
> I have an FPGA on port 0x500 on the LPC bus of an sc1200, and I just
> read and write the registers there the same as any other hardware.
>
> Len Sorensen

Thank you very much for your reply, Len.
I will also have an FPGA (I think it will be on port 0x1400 or so). I
am writing to LPC using 'outb' like this: outb (data, port);
So I see an I/O write on the LPC bus, that is: 2 bytes for address and
1 byte for data (it tooks one microsecond per transfer).

To speed up things, I wish to transmit more than 1 byte for data in
each transfer (if possible).
Accordingly with page 194 of the sc1200 processor data book, it is
also possible to do a "Bus Master Memory Write" to transmit 1,2 or 4
bytes.
Do you know how can I make a "Bus Master Memory Write" to the LPC?

Thank you very much, regards!
Carlos
