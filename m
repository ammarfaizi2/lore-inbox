Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750784AbWCFKrD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750784AbWCFKrD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 05:47:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752373AbWCFKrC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 05:47:02 -0500
Received: from smtp.osdl.org ([65.172.181.4]:48313 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750784AbWCFKrA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 05:47:00 -0500
Date: Mon, 6 Mar 2006 02:45:12 -0800
From: Andrew Morton <akpm@osdl.org>
To: Matthew Grant <grantma@anathoth.gen.nz>
Cc: dwmw2@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM:  rt_sigsuspend() does not return EINTR on 2.6.16-rc2+
Message-Id: <20060306024512.4594b58d.akpm@osdl.org>
In-Reply-To: <1141633685.7634.13.camel@localhost.localdomain>
References: <1141521960.7628.9.camel@localhost.localdomain>
	<1141557862.3764.47.camel@pmac.infradead.org>
	<1141633685.7634.13.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Grant <grantma@anathoth.gen.nz> wrote:
>
> OK, a major piece of software is broken for mounting removable media. A
>  kernel upgrade from 2.6.15 SHOULDn't do that.  

Yes, this is a serious problem and we need to get to the bottom of it.

Could you please describe, in super-simple steps, how one should go about
reproducing it?

Also, the entire strace output for both good and bad kernels might be
useful.  Am wondering what your fd #4 refers to.

A socket, I guess.  It _might_ not be a signal or poll problem at all (but
it probably is, given the track record of those patches).

Do you have time to do a git-bisect?
