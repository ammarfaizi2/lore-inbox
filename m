Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264635AbUFSQww@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264635AbUFSQww (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 12:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264627AbUFSQvW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 12:51:22 -0400
Received: from ultra12.almamedia.fi ([193.209.83.38]:429 "EHLO
	ultra12.almamedia.fi") by vger.kernel.org with ESMTP
	id S264648AbUFSQeT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 12:34:19 -0400
Message-ID: <40D46B54.77737F3A@users.sourceforge.net>
Date: Sat, 19 Jun 2004 19:35:32 +0300
From: Jari Ruusu <jariruusu@users.sourceforge.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.22aa1r7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andreas Gruenbacher <agruen@suse.de>
Cc: 4Front Technologies <dev@opensound.com>, linux-kernel@vger.kernel.org
Subject: Re: Stop the Linux kernel madness
References: <40D232AD.4020708@opensound.com> <3217460000.1087518092@flay>
			 <40D23701.1030302@opensound.com> <1087573691.19400.116.camel@winden.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Gruenbacher wrote:
> On Fri, 2004-06-18 at 02:27, 4Front Technologies wrote:
> > Our commercial OSS drivers work perfectly with Linux 2.6.5, 2.6.6, 2.6.7
> > and they are failing to install with SuSE's 2.6.5 kernel. The reason is that
> > they have gone and changed the kernel headers which mean that nothing works.
> 
> Not really. The 2.6 kernel series allow to put output files in a
> different directory than the sources -- see the O= option; there is a
> little documentation in the main Makefile. Without the O= option, the
> kernel sources and object files needed to compile external modules will
> reside in the same directory. With the O= option, they will reside in
> different directories. This means that a single /lib/modules/$(uname
> -r)/build symlink is not sufficient anymore. Therefore we have the build
> symlink pointing to the output files, and a new source symlink pointing
> to the real source tree.

Which is wrong, because existing behavior in separate source and object
directory case is that 'build' symlink points to source tree.

You BROKE it by redirecting it elsewhere.

> This change hasn't found its way into mainline yet, which is unfortunate.

I hope that your breakage never gets merged to mainline.

-- 
Jari Ruusu  1024R/3A220F51 5B 4B F9 BB D3 3F 52 E9  DB 1D EB E3 24 0E A9 DD
