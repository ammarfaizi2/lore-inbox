Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263598AbTLEBE7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 20:04:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263778AbTLEBE7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 20:04:59 -0500
Received: from tantale.fifi.org ([216.27.190.146]:27269 "EHLO tantale.fifi.org")
	by vger.kernel.org with ESMTP id S263598AbTLEBE5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 20:04:57 -0500
To: Peter Chubb <peter@chubb.wattle.id.au>
Cc: rob@landley.net, linux-kernel@vger.kernel.org
Subject: Re: Is there a "make hole" (truncate in middle) syscall?
References: <200312041432.23907.rob@landley.net>
	<16335.47878.628726.26978@wombat.chubb.wattle.id.au>
Mail-Copies-To: nobody
From: Philippe Troin <phil@fifi.org>
Date: 04 Dec 2003 17:04:48 -0800
In-Reply-To: <16335.47878.628726.26978@wombat.chubb.wattle.id.au>
Message-ID: <873cc0nkgf.fsf@ceramic.fifi.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Chubb <peter@chubb.wattle.id.au> writes:

> >>>>> "Rob" == Rob Landley <rob@landley.net> writes:
> 
> Rob> You can make a file with a hole by seeking past it and never
> Rob> writing to that bit, but is there any way to punch a hole in a
> Rob> file after the fact?  (I mean other with lseek and write.  Having
> Rob> a sparse file as the result....)
> 
> SVr4 has fcntl(fd, F_FREESP, flock) that frees the space covered by
> the struct flock in the file.  Linux doesn't have this, at least in
> the baseline kernels.

However most SVr4 (at least Solaris and HP-UX) only implement FREESP
when the freed space is at the file's tail. In other words, FREESP can
only be used to implement ftruncate().

Phil.
