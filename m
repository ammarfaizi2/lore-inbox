Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288685AbSBRWci>; Mon, 18 Feb 2002 17:32:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288787AbSBRWc2>; Mon, 18 Feb 2002 17:32:28 -0500
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:9988 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S288685AbSBRWcS>; Mon, 18 Feb 2002 17:32:18 -0500
Date: Mon, 18 Feb 2002 23:32:03 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Ben Greear <greearb@candelatech.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Oliver Hillmann <oh@novaville.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: jiffies rollover, uptime etc.
In-Reply-To: <3C717DEA.7090309@candelatech.com>
Message-ID: <Pine.LNX.4.33.0202182327150.10570-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Feb 2002, Ben Greear wrote:

> I wonder, is it more expensive to write all drivers to handle the
> wraps than to take the long long increment hit?  The increment is
> once every 10 miliseconds, right?  That is not too often, all things
> considered...

This is just a matter of getting the signed/unsigned declarations right in 
comparisons. (time_before and time_after macros were introduced to aid 
here, hint!)
No overhead is involved here.

Actually, quite a few bug fixes in this area went into 2.4.18pre, with
some more to come in 2.4.19pre.

> 
> Maybe the non-atomicity of the long long increment is the problem?

Yes.

> Does this problem still exist on 64-bit machines?
> 

No.

> THanks,
> Ben

Tim

