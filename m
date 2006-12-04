Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967345AbWLDVpN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967345AbWLDVpN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 16:45:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967367AbWLDVpM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 16:45:12 -0500
Received: from smtp.osdl.org ([65.172.181.25]:56703 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967345AbWLDVpK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 16:45:10 -0500
Date: Mon, 4 Dec 2006 13:43:26 -0800
From: Andrew Morton <akpm@osdl.org>
To: <Aucoin@Houston.RR.com>
Cc: "'Jeffrey Hundstad'" <jeffrey.hundstad@mnsu.edu>,
       "'Christoph Lameter'" <clameter@sgi.com>,
       "'Horst H. von Brand'" <vonbrand@inf.utfsm.cl>,
       "'Kyle Moffett'" <mrmacman_g4@mac.com>,
       "'Tim Schmielau'" <tim@physik3.uni-rostock.de>, <torvalds@osdl.org>,
       <linux-kernel@vger.kernel.org>, <dcn@sgi.com>
Subject: Re: la la la la ... swappiness
Message-Id: <20061204134326.3175c1df.akpm@osdl.org>
In-Reply-To: <200612042125.kB4LPmld014172@ms-smtp-06.texas.rr.com>
References: <45746B1B.5060809@mnsu.edu>
	<200612042125.kB4LPmld014172@ms-smtp-06.texas.rr.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Dec 2006 15:25:47 -0600
"Aucoin" <Aucoin@Houston.RR.com> wrote:

> > From: Jeffrey Hundstad [mailto:jeffrey.hundstad@mnsu.edu]
> > POSIX_FADV_NOREUSE flags.  It seems these would cause the tar and patch
> 
> WI may be na__ve as well, but that sounds interesting. Unless someone knows
> of an obvious reason this won't work we can make a one-off tar command and
> give it a whirl.
> 

Well if altering tar is an option then sure, a
sync_file_range(SYNC_FILE_RANGE_WRITE|SYNC_FILE_RANGE_WAIT_AFTER) followed
by fadvise(POSIX_FADV_DONTNEED) will free the memory up again.
