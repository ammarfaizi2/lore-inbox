Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932422AbWJAVwT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932422AbWJAVwT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 17:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932423AbWJAVwT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 17:52:19 -0400
Received: from ra.tuxdriver.com ([70.61.120.52]:35856 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S932422AbWJAVwS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 17:52:18 -0400
Date: Sun, 1 Oct 2006 17:47:56 -0400
From: Neil Horman <nhorman@tuxdriver.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
       mj@atrey.karlin.mff.cuni.cz, davej@redhat.com
Subject: Re: [PATCH] x86: update vmlinux.lds.S to place .data section on a page boundary
Message-ID: <20061001214756.GA27963@hmsreliant.homelinux.net>
References: <20060928201249.GA10037@hmsreliant.homelinux.net> <20060928204220.GA31096@uranus.ravnborg.org> <20060928232206.GA11386@hmsreliant.homelinux.net> <20060929000301.GB11386@hmsreliant.homelinux.net> <m11wpugnqt.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m11wpugnqt.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2006 at 07:13:46PM -0600, Eric W. Biederman wrote:
> Neil Horman <nhorman@tuxdriver.com> writes:
> 
> > Sorry, Replying to myself.  I forgot to mention in my last note why specifically
> > I was calling for this change, and why it was necessecary.  In addition to being
> > the standard in the script for executable sections, kexec also appears to rely
> > on PT_LOAD sections being on page boundaries.  With vmlinux.ld.s as it is, that
> > isn't the case, and so we can't load any kernels with kexec at the moment.  I've
> > seen this on the most recent fedora kernels (which have the latest version of
> > this linker script), and this patch corrects that.
> >
> > Please look at the file in its entirety, and if you still feel that modifying
> > the script so all the ALIGN(4096) directives to be ALIGN(PAGE_SIZE) instead is
> > the direction to go, I'll implement the change and test it out.
> 
> Is there a reason you don't want to kexec the bzImage?
> 
Not so much that I don't want to, but I don't think you should have to.  There
isn't any reason that we shouldn't be able to boot uncompressed kernels, is
there?
Regards
Neil

> Eric
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
/***************************************************
 *Neil Horman
 *Software Engineer
 *gpg keyid: 1024D / 0x92A74FA1 - http://pgp.mit.edu
 ***************************************************/
