Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932338AbVJDDYy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932338AbVJDDYy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 23:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932341AbVJDDYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 23:24:54 -0400
Received: from zproxy.gmail.com ([64.233.162.206]:2394 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932338AbVJDDYx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 23:24:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Bv8GKLRZCb9InBf1IrRTLjBD7fuoznlOElOBl/8UPtG4E4v+BfBnh/PcbI0FmCZbQTVimb7kZKm3W9tqU3qeuIobJVeZHH01d9Zgm8LbuObIBnJ9bTvd48x58osvpcUmUgQPb/vOoEu2+Cd98q3bwgSGrXtDlR/vv9SvyY7Cj9A=
Message-ID: <aec7e5c30510032024t6d48643fma875c917acb69d92@mail.gmail.com>
Date: Tue, 4 Oct 2005 12:24:52 +0900
From: Magnus Damm <magnus.damm@gmail.com>
Reply-To: Magnus Damm <magnus.damm@gmail.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCHv2] Document from line in patch format
Cc: Paul Jackson <pj@sgi.com>, Andrew Morton <akpm@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       linux-kernel@vger.kernel.org, Coywolf Qi Hunt <coywolf@gmail.com>,
       Greg KH <greg@kroah.com>
In-Reply-To: <Pine.LNX.4.64.0510021158260.31407@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051002163244.17502.15351.sendpatchset@jackhammer.engr.sgi.com>
	 <Pine.LNX.4.64.0510021158260.31407@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/3/05, Linus Torvalds <torvalds@osdl.org> wrote:
> On Sun, 2 Oct 2005, Paul Jackson wrote:
> >
> > Document more details of patch format such as the "from" line
> > used to specify the patch author, and provide more references
> > for patch guidelines.
>
> One more issue: I'd really prefer that the "---" not be documented as
> "optional".
>
> Yes, my tools will also notice "diff -" and "Index: " at the start of the
> line as being markers for where the real patch starts, but that's a hack
> because people haven't been following the "---" rule. I'd much rather make
> it clear that the "---" is supposed to be there, to mark where the end of
> the comments are.

Huh, I thought that the first line in a unified patch started with
"---", and that the lines above were treated as garbage. Relying on
"diff -" or "Index: " seems wrong. Try diffing two files by "diff -u
file1 file2" and look at the output - the first line is "---"... This
extra "---" you are proposing seems like a workaround to me.

/ magnus
