Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964807AbVJLPK3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964807AbVJLPK3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 11:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964808AbVJLPK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 11:10:29 -0400
Received: from nproxy.gmail.com ([64.233.182.197]:58777 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964807AbVJLPK3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 11:10:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sZoIy1UPWnFx4kAOtMP+7h9Hxlf931JKrV6LrK4njKWihjDWfKZIpjLIhuONEO9/tqCSafkvd90EXmcPu1TomP5o+231q/mD1/U6CizYL0NGsvQRtx3hd1rcFSDC8qEgqyGjZg0PmOTXGz7nr3CwCy0NGGplzlIU+nKVwPwrFTs=
Message-ID: <81b0412b0510120810o6d06a678q1d4a9787687b9bfa@mail.gmail.com>
Date: Wed, 12 Oct 2005 17:10:27 +0200
From: Alex Riesen <raa.lkml@gmail.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: blocking file lock functions (lockf,flock,fcntl) do not return after timer signal
Cc: boi@boi.at, linux-kernel@vger.kernel.org
In-Reply-To: <1129127947.8561.44.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <434CC144.6000504@boi.at>
	 <81b0412b0510120548k3464d355ne75cce4e5edcce1a@mail.gmail.com>
	 <1129127947.8561.44.camel@lade.trondhjem.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/05, Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> on den 12.10.2005 Klokka 14:48 (+0200) skreiv Alex Riesen:
> > On 10/12/05, "Dieter Müller (BOI GmbH)" <dieter.mueller@boi.at> wrote:
> > > bug description:
> > >
> > > flock, lockf, fcntl do not return even after the signal SIGALRM  has
> > > been raised and the signal handler function has been executed
> > > the functions should return with a return value EWOULDBLOCK as described
> > > in the man pages
>
> Works for me on a local filesystem.
>
> Desktop$ ./gnurr gnarg
> locking...
> timeout
> timeout
> timeout
> timeout
> timeout

Doesn't look so. I'd expect "flock: EWOULDBLOCK" and "sleeping" after
the first timeout.
