Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277568AbRJRDLY>; Wed, 17 Oct 2001 23:11:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277572AbRJRDLP>; Wed, 17 Oct 2001 23:11:15 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:12043 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S277568AbRJRDLG>;
	Wed, 17 Oct 2001 23:11:06 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15310.18125.367838.562789@cargo.ozlabs.ibm.com>
Date: Thu, 18 Oct 2001 13:04:45 +1000 (EST)
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: libz, libbz2, ramfs and cramfs
In-Reply-To: <9qjfki$ob5$1@cesium.transmeta.com>
In-Reply-To: <19978.1003206943@kao2.melbourne.sgi.com>
	<3BCBE29D.CFEC1F05@alacritech.com>
	<9qjfki$ob5$1@cesium.transmeta.com>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin writes:

> PPP uses a nonstandard deviant of zlib, or *so I've been told*, so
> that one is out.

PPP uses a variant of zlib with some extensions.  I believe that I
didn't break zlib for normal use when I added the extensions but I
would have to check that to be 100% sure.  The PPP zlib.c is based on
zlib-1.0.4, which is no longer the most recent version.

I think it would be possible to make PPP use the standard zlib but
with decreased performance.  It's a long time since I looked at that
stuff though.

> A major problem is that the module name "deflate" is used by PPP,
> despite it being a nonstandard format...

No, the module name is "ppp_deflate".

Paul.
