Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264371AbUADAo7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 19:44:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264382AbUADAo7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 19:44:59 -0500
Received: from thunk.org ([140.239.227.29]:18305 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S264371AbUADAo5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 19:44:57 -0500
Date: Sat, 3 Jan 2004 19:44:51 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Frank van Maarseveen <frankvm@xs4all.nl>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [2.4.24-pre3] 0/5  EXT2/3 Updates
Message-ID: <20040104004451.GB2364@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Frank van Maarseveen <frankvm@xs4all.nl>,
	linux-kernel@vger.kernel.org
References: <E1AcAhw-0000LE-Ky@thunk.org> <20040104000747.GA1706@janus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040104000747.GA1706@janus>
User-Agent: Mutt/1.5.4i
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 04, 2004 at 01:07:47AM +0100, Frank van Maarseveen wrote:
> On Thu, Jan 01, 2004 at 04:50:20PM -0500, Theodore Ts'o wrote:
> > Patch 5:  Add HTREE indexed directory support
> 
> Will this work on an NFS server? I remember an issue regarding a cookie
> representing the directory offset: The problem was that the conversion
> to HTREE of a directory while at the same time reading that directory
> over NFS would basically invalidate the directory offset.

Yes, it will work over an NFS server.  We solve this problem by having
readdir() always return directory entries of small directories (which
are eligible to be converted into HTREE format) in hash order.

						- Ted
