Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273304AbRIRKYs>; Tue, 18 Sep 2001 06:24:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273320AbRIRKYa>; Tue, 18 Sep 2001 06:24:30 -0400
Received: from ns.caldera.de ([212.34.180.1]:50869 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S273304AbRIRKYU>;
	Tue, 18 Sep 2001 06:24:20 -0400
Date: Tue, 18 Sep 2001 12:23:15 +0200
From: Christoph Hellwig <hch@ns.caldera.de>
To: David Mosberger <davidm@hpl.hp.com>
Cc: viro@math.psu.edu, torvalds@transmeta.com, linux@arm.linux.org.uk,
        ralf@gnu.ai.mit.edu, linux-kernel@vger.kernel.org,
        linux-ia64@linuxia64.org
Subject: Re: [Linux-ia64] __emul_prefix() problem
Message-ID: <20010918122314.A7015@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch>,
	David Mosberger <davidm@hpl.hp.com>, viro@math.psu.edu,
	torvalds@transmeta.com, linux@arm.linux.org.uk, ralf@gnu.ai.mit.edu,
	linux-kernel@vger.kernel.org, linux-ia64@linuxia64.org
In-Reply-To: <200109172351.QAA29928@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200109172351.QAA29928@napali.hpl.hp.com>; from davidm@hpl.hp.com on Mon, Sep 17, 2001 at 04:51:11PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2001 at 04:51:11PM -0700, David Mosberger wrote:
> I'm not sure there is a clean fix to this, but one proposal is
> attached below: it causes __emul_lookup_dentry() to ignore the
> alternate root for paths that resolve to a directory.  This obviously
> could create other problems, but I suspect there is no solution that
> works 100% in all cases (the fundamental being that we now have two
> different root nodes...).

Looks sant to me and doesn't break Linux-ABI.  For 2.5 I'd prefer
to somehow build a per-personality namespace.  Al, do you have an
idea how to keep a secondary namespace alive over the whole uptime
so non-Linu binaries can switch to it all the time (implicitly)?

	Christoph
