Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283579AbRLDXW0>; Tue, 4 Dec 2001 18:22:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283581AbRLDXWH>; Tue, 4 Dec 2001 18:22:07 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:53260 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S283579AbRLDXVt>;
	Tue, 4 Dec 2001 18:21:49 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: David Weinehall <tao@acc.umu.se>
Cc: kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [kbuild-devel] Converting the 2.5 kernel to kbuild 2.5 
In-Reply-To: Your message of "Wed, 05 Dec 2001 00:05:53 BST."
             <20011205000553.L360@khan.acc.umu.se> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 05 Dec 2001 10:21:37 +1100
Message-ID: <30766.1007508097@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Dec 2001 00:05:53 +0100, 
David Weinehall <tao@acc.umu.se> wrote:
>Would it be easy to add hooks for make-rpm and make-kpkg and alike,
>as methods for make installable?

I don't want details for any packaging method in kbuild.  kbuild's job
is to build and install the kernel, not wrap it up in a pretty package
for distribution, I have to draw the line somewhere.  In particular I
am not going to support 3-5 different packaging methods in kbuild, nor
am I going to worry about changes in the packaging process, it is SEP.

Having said that, kbuild is extensible.  Users can specify additional
targets, dependencies and rules on the command line, those become part
of the build process.  So redhat, debian, slackware, new distribution
on the block can supply a packaging script and run this command :-

  make ADD0=pkg ADD0_DEP=install ADD0_CMD='my-package-script' pkg

The packaging script is maintained by the package supplier, not by the
kbuild group.

BTW, that example is straight out of the kbuild 2.5 documentation in
Documentation/kbuild/kbuild-2.5.txt, I wish people would read that
file first.

