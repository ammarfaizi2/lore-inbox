Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130443AbQKBG2k>; Thu, 2 Nov 2000 01:28:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130459AbQKBG2a>; Thu, 2 Nov 2000 01:28:30 -0500
Received: from devserv.devel.redhat.com ([207.175.42.156]:7697 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S130443AbQKBG2X>; Thu, 2 Nov 2000 01:28:23 -0500
Date: Thu, 2 Nov 2000 01:28:13 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: Cort Dougan <cort@fsmlabs.com>
Cc: "David S. Miller" <davem@redhat.com>, npsimons@fsmlabs.com,
        garloff@suse.de, jamagallon@able.es, linux-kernel@vger.kernel.org
Subject: Re: Where did kgcc go in 2.4.0-test10 ?
Message-ID: <20001102012813.J6207@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
In-Reply-To: <20001101234058.B1598@werewolf.able.es> <20001101235734.D10585@garloff.etpnet.phys.tue.nl> <200011012247.OAA19546@pizda.ninka.net> <20001101163752.B2616@fsmlabs.com> <200011012329.PAA19890@pizda.ninka.net> <20001101165418.B3444@hq.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001101165418.B3444@hq.fsmlabs.com>; from cort@fsmlabs.com on Wed, Nov 01, 2000 at 04:54:18PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2000 at 04:54:18PM -0700, Cort Dougan wrote:
> Since you're setting yourself up as a proponent of this can you explain why
> RedHat includes a compiler that doesn't work with the kernel?  Don't get

It actually does not compile only 2.2 kernels unless they are patched (the
patches so that they can work with gcc we ship are available from H.J.'s
site).
With 2.4, the gcc we shipped just prints some wrong cpp warnings (which have
been fixed long time ago) but compiles a workable kernel.
The thing then is really about what is the recommended compiler for
compiling kernel, and it is egcs 1.1.2 at the moment, not 2.95.2, nor our
2.96, nor CVS head (the last one is known to miscompile some things in the
kernel on x86).

> grumpy about who did it first or what the old one is named but be clear
> what I'm asking.  I want to know if the 'gcc' on RedHat 7.0 fixes some
> problems that the older compilers suffered from?  If there's a good reason

Yes, it fixes several problems the older compilers suffered from, see Richard
Henderson's posting about this on lkml from end of September.

	Jakub
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
