Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314870AbSD3TCJ>; Tue, 30 Apr 2002 15:02:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315165AbSD3TCI>; Tue, 30 Apr 2002 15:02:08 -0400
Received: from mta02-svc.ntlworld.com ([62.253.162.42]:59387 "EHLO
	mta02-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S314870AbSD3TCI>; Tue, 30 Apr 2002 15:02:08 -0400
Date: Tue, 30 Apr 2002 20:01:10 +0100
From: =?ISO-8859-1?Q?Jos=E9?= Fonseca <j_r_fonseca@yahoo.co.uk>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to write portable MMIO code?
Message-ID: <20020430190110.GA20294@localhost>
In-Reply-To: <Pine.LNX.4.44.0204301112520.32217-100000@chaos.physics.uiowa.edu>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mailer: Balsa 1.3.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kai,

On 2002.04.30 17:19 Kai Germaschewski wrote:
> On Tue, 30 Apr 2002, José Fonseca wrote:
> >   - should one in general (i.e., assuming the worst case) do wmb() on
> > writes, and mb() on reads?
> 
> I don't think mb() will help you. You're probably experiencing PCI
> posting
> problems - when a writel() has executed, that doesn't necessarily mean
> that the transaction has actually happened it may (and will) be buffered
> for a potentially long time.
> 
> However, PCI won't reorder reads vs. writes, so you when you want to be
> sure that a write() actually reached the hardware, do a dummy read()
> afterwards, that'll flush the write buffer.

Unfortunately one of the problems occurs in a idle wait loop, when a 
register is being sucessively read.

And if so, how the wmb() example in "Linux Device Drivers" 
(http://www.xml.com/ldd/chapter/book/ch08.html#t1) can be explained? The 
"Bus-Independent Device Accesses" 
(http://www.kernelnewbies.org/documents/kdoc/deviceiobook/x44.html) also 
refers what you suggested, but it also mentions the use of memory 
barriers. So how and when should they be used?

Regards,

José Fonseca
