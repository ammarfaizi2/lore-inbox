Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282121AbRKWL1B>; Fri, 23 Nov 2001 06:27:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282127AbRKWL0w>; Fri, 23 Nov 2001 06:26:52 -0500
Received: from mailout03.sul.t-online.com ([194.25.134.81]:35542 "EHLO
	mailout03.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S282121AbRKWL0k>; Fri, 23 Nov 2001 06:26:40 -0500
From: 520047054719-0001@t-online.de (Oliver Neukum)
To: Christoph Hellwig <hch@ns.caldera.de>
Subject: Re: [PATCH] Remove needless BKL from release functions
Date: Fri, 23 Nov 2001 12:24:32 +0100
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rick Lindsley <ricklind@us.ibm.com>
In-Reply-To: <200111231047.fANAlA105874@ns.caldera.de>
In-Reply-To: <200111231047.fANAlA105874@ns.caldera.de>
MIME-Version: 1.0
Message-Id: <01112312243201.00804@argo>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag 23 November 2001 11:47 schrieb Christoph Hellwig:
> In article <Pine.SOL.4.33.0111231106530.7403-100000@sun3.lrz-muenchen.de> 
you wrote:
> > While this is doubtlessly true, please don't do things like removing the
> > lock from interfaces like the call to open() in the input subsystem.
> > People may depend on the lock being held there. Having open() under BKL
> > simplifies writing USB device drivers.
>
> Beeing completly single-threaded also simplifies writing unclean drivers..

This is true. However USB drivers have to cope with devices becoming 
unplugged at all times. The races this produces are not nice.

> BTW, I've attached a patch that fixes the largest input races (against
> 2.4.6), I don't see how to change the total lack of locking for other data
> structures without an API change, though.

This looks very good. Could you get this to the maintainer ?

	Regards
		Oliver

