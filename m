Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751191AbWGBRH2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbWGBRH2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 13:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbWGBRH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 13:07:28 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:24867 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751191AbWGBRH1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 13:07:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ps4JikX0o0NXcGJj8XwLb/fU4IdMdzNvDoSB1P917/TG/A+1Dx0pkzHi74B+7qBbTyljvhTn4WKaTq5Naw262aFJ3ufBF2QudtWVYLs7pjM44w2iMPz4+NDb4/SRPw+24FLR4hOnN9JQ5u++ltR1kSlpyp0Qen2XNJEkUimz9WQ=
Message-ID: <a44ae5cd0607021007v52dac771n86c25c3bff491152@mail.gmail.com>
Date: Sun, 2 Jul 2006 10:07:27 -0700
From: "Miles Lane" <miles.lane@gmail.com>
To: "Arjan van de Ven" <arjan@infradead.org>
Subject: Re: 2.6.17-mm5 -- Busted toolchain? -- usr/klibc/exec_l.c:59: undefined reference to `__stack_chk_fail'
Cc: "Andrew Morton" <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1151826131.3111.5.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <a44ae5cd0607011409m720dd23dvf178a133c2060b6d@mail.gmail.com>
	 <1151788673.3195.58.camel@laptopd505.fenrus.org>
	 <a44ae5cd0607011425n18266b02s81b3d87988895555@mail.gmail.com>
	 <1151789342.3195.60.camel@laptopd505.fenrus.org>
	 <a44ae5cd0607011537o1cf00545td19e568dcb9c06c1@mail.gmail.com>
	 <1151826131.3111.5.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/2/06, Arjan van de Ven <arjan@infradead.org> wrote:
>
> > https://wiki.ubuntu.com/GccSsp
> >
> > It appears that Ubuntu's Edgy Eft (the development tree) now contains
> > "Stack Smashing Protection" enabled by default.  I found a web page
> > that states that -fno-stack-protector can be used to disable this
> > functionality.  Interestingly, another web page stated that SSP has
> > been enabled in Redhat compilers for a long time and is now also
> > enabled in Debian SID.  Perhaps -fno-stack-protector should be added
> > to the kernel build be default?
>
>
> gcc 4.1 and later have this feature yes.
> HOWEVER the gcc people were not stupid, they did not force this on
> people, they require you to put -fstack-protector on the commandline.
> Debian and RH/Fedora do this.
> If Ubuntu patched gcc rather than just putting it in the build
> environment... then you should switch to a less braindead distribution
> really ;)
> or at least ask them to fix this.

Well, from the web page referenced at the top of this message, you
can see that they are already aware of these issues:

Cons:
    *      It breaks current upstream kernel builds and potentially
other direct usages of gcc. Kernel is by far the most important use
case. Upstream should change the default options to build with
-fno-stack-protector by default.
    *      It is not conformant to upstream gcc behaviour.

You can reach the key people who are working on this for Ubuntu here:
Matt Zimmerman -- mdz at ubuntu dot com
Martin Pitt -- martin.pitt at ubuntu dot com

Perhaps you can convince them to back out this functional change?

Does this mean that you don't want to see these fno-stack-protector
patches go into Andrew's tree?

            Miles
