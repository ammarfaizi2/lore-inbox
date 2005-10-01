Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750825AbVJATV1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbVJATV1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 15:21:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750835AbVJATV1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 15:21:27 -0400
Received: from xproxy.gmail.com ([66.249.82.194]:61962 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750783AbVJATV0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 15:21:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jDnaYQk/6ytIMpwlZ7m5KLdnx2pYsSi9BfeCQpEdkqxpHLXB88I82lFWEDu6+O2g4cxdL094BpE7M5NbgOggJqytAAti6ByCJgvRZuAZElrWHGCeYZ0sui6WSPuBXouiZz/5kzg0OJEgWrgklNjwaWWdfDn1x9suJa2fScVI9Es=
Message-ID: <d93f04c70510011221jf36525fla68c95160c0f0d38@mail.gmail.com>
Date: Sat, 1 Oct 2005 21:21:25 +0200
From: Hendrik Visage <hvjunk@gmail.com>
Reply-To: Hendrik Visage <hvjunk@gmail.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: Starfire (Adaptec) kernel 2.6.13+ panics on AMD64 NFS server
Cc: Andrew Morton <akpm@osdl.org>, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org, ionut@badula.org,
       Jeff Garzik <jgarzik@pobox.com>, netdev@vger.kernel.org
In-Reply-To: <20050930223915.GA17562@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <d93f04c70509292036x269df799y7b51c5be9c3356d6@mail.gmail.com>
	 <20050929211649.69eaddee.akpm@osdl.org>
	 <d93f04c70509300901s3836b8afw4792d16c589b4fc4@mail.gmail.com>
	 <20050930104046.4685e975.akpm@osdl.org>
	 <d93f04c70509301310y4bde1189wbcaef40124af6766@mail.gmail.com>
	 <20050930223915.GA17562@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/1/05, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> You must never call skb_checksum_help unless the packet is meant to
> be checksummed by the hardware.  So starfire is the guilty party here.
>
> This patch makes it do the check and also check for errors from
> skb_checksum_help.
>
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Thanx Herbert,
 at least on 2.6.14_rc2 the patch appears to work for my stress test :)

--
Hendrik Visage
