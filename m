Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288845AbSBRWe6>; Mon, 18 Feb 2002 17:34:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288800AbSBRWes>; Mon, 18 Feb 2002 17:34:48 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:7684 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S288814AbSBRWel>; Mon, 18 Feb 2002 17:34:41 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Make IP-Config work without ip= supplied
Date: 18 Feb 2002 14:34:25 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a4rvhh$vku$1@cesium.transmeta.com>
In-Reply-To: <20020218222451.GA23899@main.braxis.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20020218222451.GA23899@main.braxis.co.uk>
By author:    Krzysztof Rusocki <kszysiu@main.braxis.co.uk>
In newsgroup: linux.dev.kernel
> 
> Hi,
> 
> Just noticed that IP-Config behavior when no ip= parm is used has changed in
> 2.2.18.
> 
> Up to 2.2.17 IP-Config was enabled even when ip= was omitted. I think that
> it's good for use in i.e. diskless nodes.
> 
> Since 2.2.18, IP-Config does nothing at all until ip= is passed to the
> kernel, however Documentation/nfsroot.txt still says that IP-Config is
> enabled by default. Was that intentional change?
> 
> Such behavior remains in both 2.2.20 and 2.4.18-rc1. Following patches
> (against these two kernel trees) make IP-Config enabled by default.
> 

I don't think this is a good idea.  The current behaviour should work
across the board.  Diskless nodes should use a diskless bootloader
which support command lines -- that way you get to specify the mode as
well.  *ALL* nodes should use the command line these days.

Can we get rid of the g----d bootsect.S, please?

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
