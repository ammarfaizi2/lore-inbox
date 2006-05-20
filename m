Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751477AbWETUX0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751477AbWETUX0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 16:23:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751480AbWETUX0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 16:23:26 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:63659 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751477AbWETUXZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 16:23:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SujCEtesHXAEsI9ScIREacaHPbIatrowSoA4M865W9nDaOYyPz0NNclcdSOFBWaYfR5IRGV9OIm7HVGmCiNfPkuFydYglFqo1Q3Sj++RZ75R4+J/9gyeoydfmuCbvHd401Cv2o/iIwKcPACN5cdaXLVIggKmvtBQrWiAURwluaI=
Message-ID: <a36005b50605201323u212158e3h6a8a6419f71efeba@mail.gmail.com>
Date: Sat, 20 May 2006 13:23:24 -0700
From: "Ulrich Drepper" <drepper@gmail.com>
To: "Renzo Davoli" <renzo@cs.unibo.it>
Subject: Re: [PATCH] 2-ptrace_multi
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>, "Andi Kleen" <ak@suse.de>,
       "Daniel Jacobowitz" <dan@debian.org>, osd@cs.unibo.it,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060520183020.GC11648@cs.unibo.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060518155337.GA17498@cs.unibo.it>
	 <20060519174534.GA22346@cs.unibo.it>
	 <20060519201509.GA13477@nevyn.them.org>
	 <200605192217.30518.ak@suse.de>
	 <1148135825.2085.33.camel@localhost.localdomain>
	 <20060520183020.GC11648@cs.unibo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/20/06, Renzo Davoli <renzo@cs.unibo.it> wrote:
> Let me point out that PTRACE_MULTI is not only related to memory access.

You've already been told that syscalls are very fast.  For any small
number of calls the overhead is neglectable.  Only for possibly huge
numbers of calls (like those needed to transfer memory content) is the
overhead significant but that is irrelevant because of /proc/*/mem.

Whatever other problems you have (accessing multiple registers) is an
arch-specific problem.  If this is a real problem talk to the arch
maintainer about adding a call to get all registers at once.  This is
nothing which should be handled with a construct like hte
PTRACE_MULTI.
