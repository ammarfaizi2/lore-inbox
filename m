Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261390AbVCaM2W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261390AbVCaM2W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 07:28:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261395AbVCaM2W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 07:28:22 -0500
Received: from box3.punkt.pl ([217.8.180.76]:22798 "HELO box.punkt.pl")
	by vger.kernel.org with SMTP id S261390AbVCaM2S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 07:28:18 -0500
From: Mariusz Mazur <mmazur@kernel.pl>
To: DervishD <lkml@dervishd.net>
Subject: Re: linux-libc-headers scsi headers vs libc scsi headers
Date: Thu, 31 Mar 2005 14:26:48 +0200
User-Agent: KMail/1.7.1
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
References: <20050330162114.GA1028@DervishD> <200503302240.08200.mmazur@kernel.pl> <20050331074526.GA8614@DervishD>
In-Reply-To: <20050331074526.GA8614@DervishD>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503311426.48435.mmazur@kernel.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On czwartek 31 marzec 2005 09:45, DervishD wrote:
>     The fact is that, in the past, I've used kernel headers older
> than my running kernel for building glibc and my system worked
> seamlessly (although I don't use bleeding edge features, you know),
> but I don't want to take risks.

You risk nothing. APIs in linux change incrementally and if kernel hackers do 
want to drop support for an api, they're very vocal about it and it doesn't 
concern stuff that can blow up your computer (see oss vs. alsa).

>     I don't know which set of headers will work, and in fact I don't
> know if I must follow 'Linux From Scratch' advice and use raw kernel
> headers for building glibc and LLH headers for any other thing. I
> think I probably will use the LLH headers (including scsi) for
> everything since glibc passes the 'make check' doing that... If I
> screw my system badly, I have lotsa backups at hand.

Like I've said, you're unable to break your system this way. And I don't see 
any point in LFS suggesting using raw kernel headers to compile glibc (no you 
*can't* screw up your system by using llh unless I specifically switch ioctls 
so apps remove files instead of opening them; I just can't see any 
possibility to do it by accident).

And I'll add an entry to the llh FAQ to clear this matter up.


-- 
In the year eighty five ten
God is gonna shake his mighty head
He'll either say,
"I'm pleased where man has been"
Or tear it down, and start again
