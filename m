Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282413AbRLRPVq>; Tue, 18 Dec 2001 10:21:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282482AbRLRPVc>; Tue, 18 Dec 2001 10:21:32 -0500
Received: from m749-mp1-cvx1b.edi.ntl.com ([62.253.10.237]:18926 "EHLO
	pinkpanther.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S282413AbRLRPVT>; Tue, 18 Dec 2001 10:21:19 -0500
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200112181416.fBIEGZM15494@pinkpanther.swansea.linux.org.uk>
Subject: Re: TTY Driver Open and Close Logic
To: Telford002@aol.com
Date: Tue, 18 Dec 2001 14:16:35 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <e5.10e6703a.29509786@aol.com> from "Telford002@aol.com" at Dec 18, 2001 07:58:46 
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have been working on various serial drivers and I notice that physical
> driver close routine is called in all cases even if the physical driver
> open routine fails.  That suggests to me that a lot of the MOD_DEC/INC_COUNT
> logic in serial.c and other physical serial drivers is incorrect.  As
> serial.c seems usually to be compiled into the kernel the issue
> is not so important, but a lot of the other logic associated with
> open counts also seems incorrect.  Is this observation correct?

Possibly so. But everyone who sent me a 2.2 patch to redo it broke stuff and
caused crashes and panics. Its worth doing for 2.5.x tho - along with proper
refcounting and killing the BKL


