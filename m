Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751325AbWKBPOE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751325AbWKBPOE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 10:14:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbWKBPOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 10:14:04 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:13007 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751325AbWKBPOC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 10:14:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Sb6ttwbMcGYEn3m+W6EA9zsFEzJXfLjh/6lJFpMJl+ozwhWZICmo9dMxPdD2TKeU1ppPAxihnMMZ2wYqRp8KwgtJL90VrBP9rsqnaMwSJe+TvIgo9reILwQvRSPEJG4gJU/cCucagH54rhY9rswbWN2FTA18m99zf07Rbk2m1EE=
Message-ID: <aec7e5c30611020714qe6bcc41ucc789e3a2ca85c1f@mail.gmail.com>
Date: Fri, 3 Nov 2006 00:14:00 +0900
From: "Magnus Damm" <magnus.damm@gmail.com>
To: "Avi Kivity" <avi@qumranet.com>
Subject: Re: [ANNOUNCE] kvm howto
Cc: "Hesse, Christian" <mail@earthworm.de>, kvm-devel@lists.sourceforge.net,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>
In-Reply-To: <454A0165.7090009@qumranet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <4549F1D5.8070509@qumranet.com>
	 <200611021527.09664.mail@earthworm.de> <454A0165.7090009@qumranet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/2/06, Avi Kivity <avi@qumranet.com> wrote:
> Hesse, Christian wrote:
> > On Thursday 02 November 2006 14:25, Avi Kivity wrote:
> >
> >> I've just uploaded a HOWTO to http://kvm.sourceforge.net, including
> >> (hopefuly) everything needed to get kvm running.  Please take a look and
> >> comment.
> >>
> >
> >   CC [M]  /tmp/kvm-module/kvm_main.o
> > {standard input}: Assembler messages:
> > {standard input}:168: Error: no such instruction: `vmxon 16(%esp)'
> > {standard input}:182: Error: no such instruction: `vmxoff'
> > {standard input}:192: Error: no such instruction: `vmread %eax,%eax'
> > {standard input}:415: Error: no such instruction: `vmwrite %ebx,%esi'
> > {standard input}:1103: Error: no such instruction: `vmclear 16(%esp)'
> > {standard input}:1676: Error: no such instruction: `vmptrld 16(%esp)'
> > {standard input}:4107: Error: no such instruction: `vmwrite %esp,%eax'
> > {standard input}:4119: Error: no such instruction: `vmlaunch '
> > {standard input}:4121: Error: no such instruction: `vmresume '
> >
> > I get a number of errors compiling the module. No difference between the
> > downloaded tarball and my patched kernel tree. Any hints?
> >
>
> You need a newer binutils.  I'm using binutils-2.16.91.0.6 (gotta love
> that version number), shipped with Fedora Core 5.

The VT-extensions added by Intel and AMD only adds a limited number of
instructions each. If you want to be user friendly it might be a good
idea to implement these instructions as macros. I'm pretty sure
VT-extension support in Xen works with my old binutils version.

/ magnus
