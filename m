Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268370AbUIWTnu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268370AbUIWTnu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 15:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268306AbUIWTnu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 15:43:50 -0400
Received: from adsl-209-204-138-32.sonic.net ([209.204.138.32]:39851 "EHLO
	server.home") by vger.kernel.org with ESMTP id S268397AbUIWTnh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 15:43:37 -0400
Date: Thu, 23 Sep 2004 12:43:28 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@server.home
To: Paul Jackson <pj@sgi.com>
cc: Simon Derr <simon.derr@bull.net>, linux-kernel@vger.kernel.org
Subject: Re: [rfc][patch] 1/2 Additional cpuset features
In-Reply-To: <20040911010808.2b283c9a.pj@sgi.com>
Message-ID: <Pine.LNX.4.58.0409231238350.11694@server.home>
References: <Pine.LNX.4.58.0409101036090.2891@daphne.frec.bull.fr>
 <20040911010808.2b283c9a.pj@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -4.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The cpuset relative numbering may be essential for consistent
cpu numbering f.e. in ia64's perfmon etc. This may affect multiple
subsystems of the kernel that enumerate CPUs.

Simon's 2nd patch provides a translation that we need at SGI for perfmon
support within a cpuset. Without the virtualization some
means in user space needs to exist to translate a virtual CPU number
into a physical CPU number.

On Sat, 11 Sep 2004, Paul Jackson wrote:

> Good luck with these patches, Simon, though I do not support them.
>
> For the record, I was the one most responsible for removing these two
> patches:
>
>  1) auto task migration on cpuset change, and
>  2) cpuset relative CPU/Memory numbering.
>
> I continue to think that these can be done just as well in user space.
> A bit better in user space actually, as the locking for (1) is easier
> from user space, and the opportunity for more flexible adaption to
> different renumbering needs that (2) attempts is easier from user space.
>
> But if others find these worth persuing in kernel space, so be it.
