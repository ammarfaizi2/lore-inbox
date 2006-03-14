Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751439AbWCNUJ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439AbWCNUJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 15:09:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751402AbWCNUJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 15:09:28 -0500
Received: from THUNK.ORG ([69.25.196.29]:48276 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1751439AbWCNUJ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 15:09:27 -0500
Date: Tue, 14 Mar 2006 15:09:24 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Rob Landley <rob@landley.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: How do I get the ext3 driver to shut up?
Message-ID: <20060314200923.GC31685@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Rob Landley <rob@landley.net>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <200603132218.39511.rob@landley.net> <20060313231407.7606f0d3.akpm@osdl.org> <20060314144849.GC16264@thunk.org> <200603141141.53230.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603141141.53230.rob@landley.net>
User-Agent: Mutt/1.5.11+cvs20060126
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2006 at 11:41:53AM -0500, Rob Landley wrote:
> Just confirming: you aren't proposing a change to kernel behavior, instead the 
> the busybox mount program should set MS_VERBOSE/MS_SILENT by default if it 
> wants to avoid these messages appearing on the console?

Yes, correct.  Normally, it is useful to have error messages show up
on the console when a mount fails for whatever reason.  But when you
are doing autodetecton the stupid way (by trying to brute force mount
every single filesystem type), the error messages get annoying.  In
init/do_mounts.c, it is trying to do the exact same thing, which is
why it passes MS_VERBOSE (now MS_SILENT) as a mount option.

						- Ted
