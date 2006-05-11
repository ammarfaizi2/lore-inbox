Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751689AbWEKNPz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751689AbWEKNPz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 09:15:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751694AbWEKNPz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 09:15:55 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:36031 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751689AbWEKNPy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 09:15:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=e+cBy7xz3D725DpiHPoth82VDSy3UMkASklV1yfmunBrzaN3L1Fv3eBXbvmy20KlAFhuwYkyOsRaatqPN+0loC2ea3S865YKpqTBK+pd3JxK/LMJTQTMZ+Op6kjxqV3ipCMlf881TYffQIgEiBkKdVTASexrjwS1uvC7WMvhX7g=
Message-ID: <bae323a50605110615gc243967l64a5e80ca620f437@mail.gmail.com>
Date: Thu, 11 May 2006 15:15:53 +0200
From: "Carlos Ojea Castro" <nuudoo.fb@gmail.com>
To: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Subject: Re: LPC bus in a geode sc1200
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060510153950.GE2835@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <bae323a50605090211t6af09c75u7cab1aac71e0e412@mail.gmail.com>
	 <20060509142851.GA2837@csclub.uwaterloo.ca>
	 <bae323a50605100055q7fbe9470q889874316348c2c3@mail.gmail.com>
	 <20060510153950.GE2835@csclub.uwaterloo.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/06, Lennart Sorensen <lsorense@csclub.uwaterloo.ca> wrote:
> On Wed, May 10, 2006 at 09:55:47AM +0200, Carlos Ojea Castro wrote:
> > Thank you very much for your reply, Len.
> > I will also have an FPGA (I think it will be on port 0x1400 or so). I
> > am writing to LPC using 'outb' like this: outb (data, port);
> > So I see an I/O write on the LPC bus, that is: 2 bytes for address and
> > 1 byte for data (it tooks one microsecond per transfer).
> >
> > To speed up things, I wish to transmit more than 1 byte for data in
> > each transfer (if possible).
> > Accordingly with page 194 of the sc1200 processor data book, it is
> > also possible to do a "Bus Master Memory Write" to transmit 1,2 or 4
> > bytes.
> > Do you know how can I make a "Bus Master Memory Write" to the LPC?
>
> Well I know we don't do that.  We have very little data, just board
> status information from various places on the board.  LPC does support
> doing DMA, which I believe is done in the same way it was done on ISA at
> least as far as the software is concerned.  How to implement DMA for LPC
> in the FPGA I have no idea.  The LPC specifications would probably tell
> you.  I imagine it involves setting up a DMA buffer in RAM (in the first
> 16MB probably) and then sending a command to the FPGA telling it to do a
> DMA transfer from that memory location using the LPC DMA commands.
>
> Len Sorensen

Well at this moment, using the low address byte to transmit data, I
can transmit 100.000 bytes in about 63 milliseconds, maybe it is
enough. Will try DMA anyway...
Thank you very much!

Regards,
Carlos
