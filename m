Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281217AbRKLCWI>; Sun, 11 Nov 2001 21:22:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281218AbRKLCV6>; Sun, 11 Nov 2001 21:21:58 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:59396 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S281217AbRKLCVs>; Sun, 11 Nov 2001 21:21:48 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFT] final cur of tr based current for -ac8
Date: 11 Nov 2001 18:21:37 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9snbnh$dg6$1@cesium.transmeta.com>
In-Reply-To: <20011110173331.F17437@redhat.com> <Pine.LNX.4.33.0111111119270.305-100000@mikeg.weiden.de> <20011111190114.A31746@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20011111190114.A31746@redhat.com>
By author:    Benjamin LaHaise <bcrl@redhat.com>
In newsgroup: linux.dev.kernel
>
> On Sun, Nov 11, 2001 at 11:58:30AM +0100, Mike Galbraith wrote:
> > The below seems to make flogging noises, but is likely too soggy.
> 
> Erk, the behaviour of str with your patch isn't quite compatible 
> enough for a smooth transition.  What is really needed is to have 
> "str" error out or generate the existing strl with a huge warning 
> about unspecified type.  Either way the kernel has to work with 
> both old and new tools for a brief period of time.
> 

The current behaviour is a bug, plain and simple.  The only way to
make backwards-compatible behaviour is to make "strl %eax" and "strw
%ax" behave properly while "str %ax" really does an "strl %eax" (the
current, broken, behaviour.)

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
