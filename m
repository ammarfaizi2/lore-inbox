Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262143AbSJJWio>; Thu, 10 Oct 2002 18:38:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262208AbSJJWio>; Thu, 10 Oct 2002 18:38:44 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:7443
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S262143AbSJJWin>; Thu, 10 Oct 2002 18:38:43 -0400
Date: Thu, 10 Oct 2002 15:44:17 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Giuliano Pochini <pochini@shiny.it>
Cc: Helge Hafting <helgehaf@aitel.hist.no>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] O_STREAMING - flag for optimal streaming I/O
Message-ID: <20021010224417.GA2673@matchmail.com>
Mail-Followup-To: Giuliano Pochini <pochini@shiny.it>,
	Helge Hafting <helgehaf@aitel.hist.no>,
	linux-kernel@vger.kernel.org
References: <3DA55E0C.24033BB5@aitel.hist.no> <XFMail.20021010151735.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <XFMail.20021010151735.pochini@shiny.it>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2002 at 03:17:35PM +0200, Giuliano Pochini wrote:
> O_STREAMING is a way to reduce cache footprint of some
> files, ad it does the job very well, unless those files
> are accessed concurrently by two of more processes.
> Thing again about to backup a large database. I don't
> want to use tar because it kills the caches. I would
> like a way to read the db so that the cached part of
> the db (the 20% which gets 80% of accesses) is not
> expunged.

Unless you are pausing the database (causing the files on disk to be in a
useful state) and then reading the file you will have trouble.  Anything
else will have to syncronize with the database itself, and thus can't use
O_STREAMING.
