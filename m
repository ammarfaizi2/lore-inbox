Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267373AbRGKRUW>; Wed, 11 Jul 2001 13:20:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267370AbRGKRUC>; Wed, 11 Jul 2001 13:20:02 -0400
Received: from imo-d05.mx.aol.com ([205.188.157.37]:25554 "EHLO
	imo-d05.mx.aol.com") by vger.kernel.org with ESMTP
	id <S267369AbRGKRTw>; Wed, 11 Jul 2001 13:19:52 -0400
Date: Wed, 11 Jul 2001 13:19:45 -0400
From: hunghochak@netscape.net (Ho Chak Hung)
To: mikeg@wen-online.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: __alloc_pages 4 order allocation failed
Mime-Version: 1.0
Message-ID: <448CBB1C.4314B00D.0F76C228@netscape.net>
In-Reply-To: <Pine.LNX.4.33.0107110720200.709-100000@mikeg.weiden.de>
X-Mailer: Franklin Webmailer 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
but there isn't any call in the module to allocate 4 order pages. There are only calls to allocate 0 order pages. alloc_pages(GFP_KERNEL, 0)is the only call to allocate page in the whole module.

Mike Galbraith <mikeg@wen-online.de> wrote:
>
> On Tue, 10 Jul 2001, Ho Chak Hung wrote:
> 
> > Hi,
> >
> > When I run a module, sometimes it gives such an error __alloc_pages 4 order allocation failed.
> > However, there is only 0 order page allocation function call within the whole module.
> > Does anyone know where does the 4 order allocation failure comes from?
> > Thanks
> 
> Memory fragmentation.  It is never safe to assume that high order
> allocations will succeed.
> 
>     -Mike
> 
> 
__________________________________________________________________
Get your own FREE, personal Netscape Webmail account today at http://webmail.netscape.com/
