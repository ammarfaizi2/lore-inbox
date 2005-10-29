Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751418AbVJ2GEA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751418AbVJ2GEA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 02:04:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751419AbVJ2GEA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 02:04:00 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:160 "EHLO ZenIV.linux.org.uk")
	by vger.kernel.org with ESMTP id S1751418AbVJ2GD7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 02:03:59 -0400
Date: Sat, 29 Oct 2005 07:03:44 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Richard Knutsson <ricknu-0@student.ltu.se>
Cc: Jens Axboe <axboe@suse.de>, arnd@arndb.de, davej@redhat.com,
       kaos@ocs.com.au, linux-kernel@vger.kernel.org
Subject: Re: 2.6.14 assorted warnings
Message-ID: <20051029060344.GB7992@ftp.linux.org.uk>
References: <5455.1130484079@kao2.melbourne.sgi.com> <20051028073049.GA27389@redhat.com> <200510281007.42758.arnd@arndb.de> <20051028082944.GI11441@suse.de> <43630FDA.7010101@student.ltu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43630FDA.7010101@student.ltu.se>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 29, 2005 at 07:59:54AM +0200, Richard Knutsson wrote:
> And on an philosophical plane, can/should we put that responsibility onto 
> the compiler? Is it not "easier" to make the functions take care
> of its own duties (like the *nix-way) and make the bvec_alloc_bs initialize 
> idx (even if it has to be an error-value)?
> 
> I'm thinking something like this. Seems alright?

No.  Working around the false positives in compiler warning system is
*wrong*.  _IF_ it cares to inline the function and generate the
warnings based on that, it is responsible for doing it right.

It's a gcc bug, plain and simple.
