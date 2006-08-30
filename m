Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750934AbWH3Q0o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750934AbWH3Q0o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 12:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751129AbWH3Q0o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 12:26:44 -0400
Received: from smtp102.sbc.mail.mud.yahoo.com ([68.142.198.201]:19812 "HELO
	smtp102.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750934AbWH3Q0n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 12:26:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=qSGQCBf6NisSc/huY4mMO4VD2t6rwd+44tSgmOuySJx3qVTgqFjEHt6XvEYX23Kr+dyIutw9AOMTUlCYRRsCZ3C21VHFEklkodC13Hh8VRKksnsK6+2NrrzD1siDzSCo0PdSZyy9YtK8Pkp4+804AIvXmF3Jx0kxjRSBpKLeo1k=  ;
From: David Brownell <david-b@pacbell.net>
To: stephen@streetfiresound.com
Subject: Re: [spi-devel-general] [Patch] Add spi full duplex mode transfer support
Date: Wed, 30 Aug 2006 09:26:31 -0700
User-Agent: KMail/1.7.1
Cc: Manish Jaggi <manish.jaggi@gmail.com>,
       spi-devel-general@lists.sourceforge.net, Luke Yang <luke.adi@gmail.com>,
       linux-kernel@vger.kernel.org
References: <489ecd0c0608292140m483bba2fqa300b55c5f4acf26@mail.gmail.com> <2e2add590608300337h3e7e806bs69b63b24d73a104c@mail.gmail.com> <1156953418.6555.13.camel@localhost>
In-Reply-To: <1156953418.6555.13.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608300926.32532.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 30 August 2006 8:56 am, Stephen Street wrote:

> My experiance has shown the most stack allocated transfer buffers are
> not 8 byte aligned and thus use PIO mode.

Of course, providing a transfer buffer on the stack is nonportable;
it's not DMA-safe (especially on systems with dma-incoherent caches!),
while transfer buffers are required to be DMA-safe so that controller
buffers can choose to use DMA for _all_ transfers if they want.

- Dave


