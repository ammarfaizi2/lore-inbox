Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266417AbSLJA0q>; Mon, 9 Dec 2002 19:26:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266425AbSLJA0q>; Mon, 9 Dec 2002 19:26:46 -0500
Received: from pc1-cwma1-5-cust42.swan.cable.ntl.com ([80.5.120.42]:1983 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266417AbSLJA0o>; Mon, 9 Dec 2002 19:26:44 -0500
Subject: Re: [PATCH] Re: #! incompatible -- binfmt_script.c broken?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3DF53549.9080403@zytor.com>
References: <9633612287A@vcnet.vc.cvut.cz>
	<20021206090234.GA1940@zaurus>	<3DF4DEC0.3030800@zytor.com>	<20021209182605.
	 GA22747@atrey.karlin.mff.cuni.cz> 	<at2qin$fgn$1@cesium.transmeta.com>
	<1039480856.12051.14.camel@irongate.swansea.linux.org.uk> 
	<3DF53549.9080403@zytor.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 10 Dec 2002 01:11:10 +0000
Message-Id: <1039482671.12051.24.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-12-10 at 00:28, H. Peter Anvin wrote:
> Alan Cox wrote:
> > 
> > I'd rather keep it as is. We should be doing IFS partition with quoting,
> > UTF-8 awareness according to locale and locale specific rules on
> > whitespace. That says "userspace" all over it. 
> > 
> 
> Actually, I would argue we definitely should *not*.

I don't see how you can do otherwise. The very definition of
"whitespace" is locale specific. Throwing it at the target as one string
lets the kernel stay out of locales, languages, policy and other parsing
horrors. Splitting it has to be done properly or its a non reversible
operation and tools can't correct the kernel screwups

