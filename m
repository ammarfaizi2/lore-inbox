Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751811AbWEPMeH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751811AbWEPMeH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 08:34:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751812AbWEPMeF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 08:34:05 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:9323 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751811AbWEPMeD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 08:34:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=KMG7j+bxAx6Ak+oB+BsHtP12sLHWQ2N1WNiPH68CP5ZslZjY4VNPirCa6JKWyVhCC/uD8lvA1ZmuffzIKsGy62oBNc49XPzi/2zPBzq7I0oBthVEY56wu4KfddfaYVowR7jvFoHhSqycS3Nu9I1BGHazYYo2TaU1a1Oz8hYk5Ac=
Message-ID: <39e6f6c70605160534s752676c0wa88121e9eef7cae8@mail.gmail.com>
Date: Tue, 16 May 2006 09:34:01 -0300
From: "Arnaldo Carvalho de Melo" <acme@ghostprotocols.net>
To: "Chris Boot" <bootc@bootc.net>
Subject: Re:
Cc: "kernel list" <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
       grsecurity@grsecurity.net
In-Reply-To: <EA629E23-98F8-4CB0-96B0-259C2A30BDFF@bootc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <EA629E23-98F8-4CB0-96B0-259C2A30BDFF@bootc.net>
X-Google-Sender-Auth: db4f22f80ad2a82b
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/16/06, Chris Boot <bootc@bootc.net> wrote:
> Hi,
>
> I've just seen the following assertions pop out of one of my servers
> running 2.6.16.9 with grsecurity. I've searched the archives of LKML
> and netdev and I've only found posts relating to 2.6.9, after which
> some related bugs were fixed... It looks like these bugs are related
> to e1000, which is the driver I'm using. The system was running 24
> days before these appeared and it's still running absolutely fine.
>
> May 16 09:15:12 baldrick kernel: [6442250.504000] KERNEL: assertion (!
> sk->sk_forward_alloc) failed at net/core/stream.c (283)
> May 16 09:15:12 baldrick kernel: [6442250.513000] KERNEL: assertion (!
> sk->sk_forward_alloc) failed at net/ipv4/af_inet.c (150)
>
> baldrick bootc # ethtool -k eth0
> Offload parameters for eth0:
> rx-checksumming: on
> tx-checksumming: on
> scatter-gather: on
> tcp segmentation offload: on

I guess just disable TSO or use latest kernel from git, it has a fix for this.

- Arnaldo
