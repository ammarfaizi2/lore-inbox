Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261436AbVD3V0t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261436AbVD3V0t (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 17:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261438AbVD3V0t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 17:26:49 -0400
Received: from zproxy.gmail.com ([64.233.162.204]:58315 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261437AbVD3V0q convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 17:26:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bjkSYR5kZEDxqeO6xmgmaW2/ky58mGuy8vAXr0FwulN77W1+tcBYdhP9qJYPfoR3Ncy+NA1PcJ2wo1thCS5SaSctX30RnIupPgkt6lMzONF22t6d3hvAxNGPPwP+911LnuBOd9g7e/mHN+rySryPtkCv39E/q9hfA1IKw85+azI=
Message-ID: <39e6f6c705043014264eb4c0c5@mail.gmail.com>
Date: Sat, 30 Apr 2005 18:26:45 -0300
From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Reply-To: acme@ghostprotocols.net
To: Jesper Juhl <juhl-lkml@dif.dk>
Subject: Re: [PATCH] resource release cleanup in net/
Cc: "David S. Miller" <davem@davemloft.net>,
       Herbert Xu <herbert@gondor.apana.org.au>,
       Jouni Malinen <jkmaline@cc.hut.fi>,
       James Morris <jmorris@intercode.com.au>,
       Pedro Roque <roque@di.fc.ul.pt>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Kunihiro Ishiguro <kunihiro@ipinfusion.com>,
       Mitsuru KANDA <mk@linux-ipv6.org>,
       lksctp-developers@lists.sourceforge.net,
       Andy Adamson <andros@umich.edu>, Bruce Fields <bfields@umich.edu>,
       netdev@oss.sgi.com, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.62.0504302219520.2094@dragon.hyggekrogen.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.62.0504302219520.2094@dragon.hyggekrogen.localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/30/05, Jesper Juhl <juhl-lkml@dif.dk> wrote:
> Hi David,
> 
> Since Andrew merged the patch that makes calling crypto_free_tfm() with a
> NULL pointer safe into 2.6.12-rc3-mm1, I made a patch to remove checks for
> NULL before calling that function, and while I was at it I removed similar
> redundant checks before calls to kfree() and vfree() in the same files.
> There are also a few tiny whitespace cleanups in there.

Jesper, I'd suggest that you left whitespaces for a separate patch, it
is always,
IMHO, better to have as small a patch as possible for reviewing.

- Arnaldo
