Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932491AbVHRWNK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932491AbVHRWNK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 18:13:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932493AbVHRWNK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 18:13:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:63901 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932491AbVHRWNI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 18:13:08 -0400
Date: Thu, 18 Aug 2005 15:13:01 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: cw@f00f.org, Sebastian.Classen@freenet-ag.de, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: overflows in /proc/net/dev
Message-ID: <20050818151301.23c4bc1e@dxpl.pdx.osdl.net>
In-Reply-To: <20050818.143248.58283961.davem@davemloft.net>
References: <1124350090.29902.8.camel@basti79.freenet-ag.de>
	<20050818163358.GA19554@taniwha.stupidest.org>
	<20050818.143248.58283961.davem@davemloft.net>
X-Mailer: Sylpheed-Claws 1.9.13 (GTK+ 2.6.7; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Aug 2005 14:32:48 -0700 (PDT)
"David S. Miller" <davem@davemloft.net> wrote:

> From: Chris Wedgwood <cw@f00f.org>
> Date: Thu, 18 Aug 2005 09:33:58 -0700
> 
> > I thought the concensurs here was that because doing reliable atomic
> > updates of 64-bit values isn't possible on some (most?) 32-bit
> > architectures so we need additional locking to make this work which is
> > undesirable?  (It might even be a FAQ by now as this comes up fairly
> > often).
> 
> That's correct.

Also width of fields in /proc/net/dev can't change without potentially
breaking ABI of applications.
