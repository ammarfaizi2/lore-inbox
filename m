Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266411AbSLIX4b>; Mon, 9 Dec 2002 18:56:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266425AbSLIX4a>; Mon, 9 Dec 2002 18:56:30 -0500
Received: from pc1-cwma1-5-cust42.swan.cable.ntl.com ([80.5.120.42]:2238 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266411AbSLIX43>; Mon, 9 Dec 2002 18:56:29 -0500
Subject: Re: [PATCH] Re: #! incompatible -- binfmt_script.c broken?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <at2qin$fgn$1@cesium.transmeta.com>
References: <9633612287A@vcnet.vc.cvut.cz> <20021206090234.GA1940@zaurus>
	<3DF4DEC0.3030800@zytor.com>
	<20021209182605.GA22747@atrey.karlin.mff.cuni.cz> 
	<at2qin$fgn$1@cesium.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 10 Dec 2002 00:40:55 +0000
Message-Id: <1039480856.12051.14.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-12-09 at 19:23, H. Peter Anvin wrote:
> We probably can, but a better question is really: what are the
> semantics that users expect?  Given that Unices are by and large
> inconsistent, we should pick the behaviour that makes sense to the
> most people.  I suspect that most people would expect whitespace
> partition.

I'd rather keep it as is. We should be doing IFS partition with quoting,
UTF-8 awareness according to locale and locale specific rules on
whitespace. That says "userspace" all over it. 

We can keep this out of kernel which is good - though it reminds me we
do need to fix backspace/delete in the tty layer on a unicode configured
tty to do the right thing. (Extra ioctls for unicode delete characters
are a longer less funny subject though)


