Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275377AbRJBPlD>; Tue, 2 Oct 2001 11:41:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275381AbRJBPky>; Tue, 2 Oct 2001 11:40:54 -0400
Received: from cr154328-a.ktchnr1.on.wave.home.com ([24.114.24.215]:56206 "EHLO
	thor.voskamp.ca") by vger.kernel.org with ESMTP id <S275377AbRJBPko>;
	Tue, 2 Oct 2001 11:40:44 -0400
From: Jeff Voskamp <jeff@cr154328-a.ktchnr1.on.wave.home.com>
Message-Id: <200110021540.f92FeBH09317@thor.voskamp.ca>
Subject: Re: Untitled
To: jdthood@home.dhs.org (Thomas Hood)
Date: Tue, 2 Oct 2001 11:40:11 -0400 (EDT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011002153222.5ED6710E6@thanatos.toad.net> from "Thomas Hood" at Oct 02, 2001 11:32:22 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> > Hello,
> > I have written a linux kernel module. The linux version is 2.2.14. 
> > In this module I have declared an array of size 2048. If I use this array, the execution of this module function
> > causes kernel to reboot. If I kmalloc() this array then execution of this module function doesnot cause any
> > problem.
> > Can you explain this behaviour?
> > Thnaks,
> > Dinesh
> 
> Hmm.  Perhaps there's is a bug in your module.
> 
> -- 
> Thomas Hood
> (Don't reply to the From: address but to jdthood_AT_yahoo.co.uk)

 
More likely he's causing a kernel stack overflow.  If it's a local variable
it's going to be either 4k or 8k (int or long) and the kernel stack is only
8k on intel.  Try making it a static array outside of any function.
 
Jeff Voskamp
