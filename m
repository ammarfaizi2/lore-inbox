Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751307AbVKSE1y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbVKSE1y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 23:27:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751353AbVKSE1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 23:27:54 -0500
Received: from 22.107.233.220.exetel.com.au ([220.233.107.22]:49668 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1751307AbVKSE1x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 23:27:53 -0500
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Arijit.Das@synopsys.com (Arijit Das)
Subject: Re: Does Linux has File Stream mapping support...?
Cc: linux-kernel@vger.kernel.org
Organization: Core
In-Reply-To: <7EC22963812B4F40AE780CF2F140AFE920904A@IN01WEMBX1.internal.synopsys.com>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1EdKKF-00065J-00@gondolin.me.apana.org.au>
Date: Sat, 19 Nov 2005 15:27:43 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arijit Das <Arijit.Das@synopsys.com> wrote:
> Is it possible to have File Stream Mapping in Linux? What I mean is
> this...
> 
> FILE * fp1 = fopen("/foo", "w");
> FILE * fp2 = fopen("/bar", "w");
> FILE * fp_common = <Stream_Mapping_Func>(fp1, fp2);
> 
> fprint(fp_common, "This should be written to both files ... /foo and
> /bar");

Yes, as long as you're using glibc you can implement this using
"Custom Streams".  Look for the function fopencookie in your glibc
documentation.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
