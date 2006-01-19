Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161221AbWASPBr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161221AbWASPBr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 10:01:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161224AbWASPBr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 10:01:47 -0500
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34]:20824 "HELO
	smtp003.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1161221AbWASPBq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 10:01:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=0DWWlfJ5F9uEnpPzkbchaF9sQvFTLtWM5opc4PfaObCqD20bzYjaJ7S2TtGVhMUro04WirX1QBKmTLa8rGMyR/BTEJyd+fIu4pDg4ki3vn1/87D2mfe0QZFnOfPlz67TL297fV099GjjJf28MmEaycQuTKcXj9d2yhOXnjqFKy8=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] [PATCH 8/8] uml: avoid "CONFIG_NR_CPUS undeclared" bogus error messages
Date: Thu, 19 Jan 2006 16:01:28 +0100
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
References: <20060118235132.4626.74049.stgit@zion.home.lan> <20060118235522.4626.2825.stgit@zion.home.lan> <20060119042104.GC8265@ccure.user-mode-linux.org>
In-Reply-To: <20060119042104.GC8265@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601191601.31805.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 19 January 2006 05:21, Jeff Dike wrote:
> On Thu, Jan 19, 2006 at 12:55:23AM +0100, Paolo 'Blaisorblade' Giarrusso 
wrote:
> > -extern struct task_struct *idle_threads[NR_CPUS];
> > -
>
> BTW, this isn't the only problem there.  There are three declarations
> towards the bottom with struct task_struct in them which have to be moved.

I saw that after, but let's say a thing which I always forgot to say:

we're often using void * in protos when we can't include a type declaration in 
the needed file.

Gerd Knorr in his tty patch, instead, used forward declarations, like:

struct task_struct; 

what about that?

Those functions probably should be moved anyway because they're useless there, 
but I'm using this occasion to avoid forgetting this.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

		
___________________________________ 
Yahoo! Messenger with Voice: chiama da PC a telefono a tariffe esclusive 
http://it.messenger.yahoo.com
