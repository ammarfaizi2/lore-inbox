Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030244AbWJ2VAB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030244AbWJ2VAB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 16:00:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030246AbWJ2VAA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 16:00:00 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:45440 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030247AbWJ2U75 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 15:59:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=LNmt8eukdTgZHf45yJBpJIOIcHAztFYKiR+NIWlXOoFtP+GZbxUesp+dHffjVfS6ZVnN9iDwAdimLvmA72CZeX7BzySF17Oy5l52n0tLQjwqepeG1cxFnFkt5Y275rSzcRYbTFj3oMUCQG5YQaRiuKa3DKd1sT0IvKaqvfbC4EI=
From: Denis Vlasenko <vda.linux@googlemail.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: 2.6.18 forcedeth GSO panic on send
Date: Sun, 29 Oct 2006 22:57:54 +0100
User-Agent: KMail/1.8.2
Cc: Manfred Spraul <manfred@colorfullife.com>, Jeff Garzik <jeff@garzik.org>,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       "David S. Miller" <davem@davemloft.net>
References: <200610270117.57877.vda.linux@googlemail.com> <20061029141029.GA5084@gondor.apana.org.au> <200610292245.40702.vda.linux@googlemail.com>
In-Reply-To: <200610292245.40702.vda.linux@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610292257.54655.vda.linux@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 29 October 2006 22:45, Denis Vlasenko wrote:
> On Sunday 29 October 2006 15:10, Herbert Xu wrote:
> > On Sun, Oct 29, 2006 at 01:55:56PM +0100, Denis Vlasenko wrote:
> > > With "echo 1 >/proc/sys/kernel/panic_on_oops" I've got
> > > what you're requested. See screenshot:
> > > 
> > > http://busybox.net/~vda/gso_panic/forcedeth_gso_panic2.jpg
> > 
> > Thanks!
> > 
> > Please let me know if this patch fixes it:
> > 
> > [NET]: Fix segmentation of linear packets
> 
> Okay, will test now.

Patch seems to fix the issue. Thanks.

> setting on it? Also what is the ethtool -k setting on the
> interface where you expect ssh to go out?

# ethtool -k if
Offload parameters for if:
rx-checksumming: on
tx-checksumming: on
scatter-gather: on
tcp segmentation offload: on
--
vda
