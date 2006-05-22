Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751190AbWEVVLk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190AbWEVVLk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 17:11:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbWEVVLk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 17:11:40 -0400
Received: from nz-out-0102.google.com ([64.233.162.194]:52442 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751190AbWEVVLk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 17:11:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gFm+aPqqzFwxJf36xBkHnSoJRohVIHJ5bBNd/87Aw6l1hbOsuyr8SOdq687InyHtg4duL6CT+wzMtaMPH37kh8m60kEffDlZUsOAl5yzmCbaWidVQH60USW2ZBNRulYp12IjjTeXI1Sla0WGb255HRe3R5PgwjQzsG1BnpENs2g=
Message-ID: <bda6d13a0605221411xa53b14dw345ed9d2b500ab8d@mail.gmail.com>
Date: Mon, 22 May 2006 14:11:39 -0700
From: "Joshua Hudson" <joshudson@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel Source Compression
In-Reply-To: <44722756.5090902@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.64.0605211028100.4037@p34>
	 <200605222015.01980.s0348365@sms.ed.ac.uk>
	 <Pine.LNX.4.61.0605222220190.6816@yvahk01.tjqt.qr>
	 <200605222200.18351.s0348365@sms.ed.ac.uk>
	 <44722756.5090902@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/22/06, H. Peter Anvin <hpa@zytor.com> wrote:
> Alistair John Strachan wrote:
[snip]
> > Seriously, though, if I understand gzip correctly, it uses deflate/zlib
> > internally. Why, in that case, does /bin/gzip not (dynamically) link against
> > libz? If a first step was fixing that, a second could be linking dynamically
> > against libbz2 and 'liblzma', and making it all compile-time configurable.
> >
>
> Because gzip predates zlib...
>
Also because it runs faster than zlib on x86 due to register pressure.
Relocatable
code costs one register. x86 only has 7 that an algorithm can scribble over
(8 if it doesn't have any stack).
