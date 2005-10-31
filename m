Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932389AbVJaA5e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932389AbVJaA5e (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 19:57:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932390AbVJaA5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 19:57:34 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:56714 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932389AbVJaA5d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 19:57:33 -0500
Date: Mon, 31 Oct 2005 00:57:26 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Paul Mackerras <paulus@samba.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Jones <davej@redhat.com>,
       Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.14 assorted warnings
Message-ID: <20051031005726.GS7992@ftp.linux.org.uk>
References: <5455.1130484079@kao2.melbourne.sgi.com> <20051028073049.GA27389@redhat.com> <1130710531.32734.5.camel@localhost.localdomain> <17253.27399.700034.125453@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17253.27399.700034.125453@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2005 at 11:53:27AM +1100, Paul Mackerras wrote:
> Gcc will warn on the use of x when in fact it is perfectly OK, and we
> get quite a few of these in compiling a kernel.  At a minimum, I would
> like to be able to disable the "may be used uninitialized" warnings
> while still getting the "is used uninitialized" warnings.

Quite.  "may be used uninitialized" has _way_ too low S/N ratio - absolute
majority of these warnings are bogus.  Moreover, several very common use
patterns reliably trigger them.
