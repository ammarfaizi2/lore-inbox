Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267122AbSLDWVQ>; Wed, 4 Dec 2002 17:21:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267123AbSLDWVQ>; Wed, 4 Dec 2002 17:21:16 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:6409 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267122AbSLDWVP>; Wed, 4 Dec 2002 17:21:15 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: #! incompatible -- binfmt_script.c broken?
Date: 4 Dec 2002 14:28:40 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <aslvio$112$1@cesium.transmeta.com>
References: <20021204113419.GA20282@merlin.emma.line.org> <20021204142628.GE26745@riesen-pc.gr05.synopsys.com> <20021204183710.GA4004@merlin.emma.line.org> <E18JgHI-0006Gx-00@chiark.greenend.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <E18JgHI-0006Gx-00@chiark.greenend.org.uk>
By author:    Matthew Garrett <mgarrett@chiark.greenend.org.uk>
In newsgroup: linux.dev.kernel
> 
> The *only* thing you can reliably use in #! lines is an interpreter
> followed by a single argument with no trailing space. On NetBSD with
> bash as /bin/sh:
> 
> mjg59@cysteine:/tmp$ cat foo.pl
> #!/bin/sh -- # -*- perl -*- -p
> mjg59@cysteine:/tmp$ ./foo.pl
> /bin/sh: -- # -*- perl -*- -p: unrecognized option
> 
> File a bug against perlrun(1).
> 

I personally think that it would be nice to split it by spaces (but
yes, ' " and \ need to be handled for this to work.)  It allows things
like using env to spawn a binary where the location of the interpreter
is to be extracted from PATH, for example.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
