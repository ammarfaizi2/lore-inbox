Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278914AbRJVUvX>; Mon, 22 Oct 2001 16:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278909AbRJVUvL>; Mon, 22 Oct 2001 16:51:11 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:57868 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S278908AbRJVUvA>; Mon, 22 Oct 2001 16:51:00 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] gcc 3.0.1 warnings about multi-line literals
Date: 22 Oct 2001 13:51:29 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9r20sh$aqr$1@cesium.transmeta.com>
In-Reply-To: <200110222005.f9MK5AJ15012@oss.sgi.com> <20011022161527.K23213@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20011022161527.K23213@redhat.com>
By author:    Benjamin LaHaise <bcrl@redhat.com>
In newsgroup: linux.dev.kernel
>
> On Mon, Oct 22, 2001 at 01:05:10PM -0700, John Hawkes wrote:
> > This patch eliminates gcc 3.0.1 warnings, "multi-line string literals are
> > deprecated", in two include/asm-i386 files.  Patches cleanly for at least
> > 2.4.10 and 2.4.12, and tested in 2.4.10.
> 
> Please reject this patch.  The gcc folks are wrong in this case.
> 

It's not gcc even, it's C99 which are making these explicitly
deprecated.  If you want a string literal which includes \n and are
mapped in that form, do either:

       "foo\n"
       "bar\n"
       "baz\n"

... or ..

	"foo\n\
	bar\n\
	baz"

I usually do the former.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
