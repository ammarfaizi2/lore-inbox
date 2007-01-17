Return-Path: <linux-kernel-owner+w=401wt.eu-S1752027AbXAQF6m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752027AbXAQF6m (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 00:58:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752030AbXAQF6m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 00:58:42 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:41857 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752027AbXAQF6l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 00:58:41 -0500
Subject: Re: O_DIRECT question
From: Arjan van de Ven <arjan@infradead.org>
To: 7eggert@gmx.de
Cc: Helge Hafting <helge.hafting@aitel.hist.no>,
       Michael Tokarev <mjt@tls.msk.ru>, Chris Mason <chris.mason@oracle.com>,
       Linus Torvalds <torvalds@osdl.org>, dean gaudet <dean@arctic.org>,
       Viktor <vvp01@inbox.ru>, Aubrey <aubreylee@gmail.com>,
       Hua Zhong <hzhong@gmail.com>, Hugh Dickins <hugh@veritas.com>,
       linux-kernel@vger.kernel.org, hch@infradead.org,
       kenneth.w.chen@intel.com, akpm@osdl.org
In-Reply-To: <E1H6utT-0000g3-Aw@be1.lrz>
References: <7BYkO-5OV-17@gated-at.bofh.it> <7BYul-6gz-5@gated-at.bofh.it>
	 <7C74B-2A4-23@gated-at.bofh.it> <7CaYA-mT-19@gated-at.bofh.it>
	 <7Cpuz-64X-1@gated-at.bofh.it> <7Cz0T-4PH-17@gated-at.bofh.it>
	 <7CBcl-86B-9@gated-at.bofh.it> <7CBvH-52-9@gated-at.bofh.it>
	 <7DyYK-6lE-3@gated-at.bofh.it>  <E1H6utT-0000g3-Aw@be1.lrz>
Content-Type: text/plain
Organization: Intel International BV
Date: Tue, 16 Jan 2007 21:55:35 -0800
Message-Id: <1169013342.3457.60.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2007-01-16 at 21:26 +0100, Bodo Eggert wrote:
> Helge Hafting <helge.hafting@aitel.hist.no> wrote:
> > Michael Tokarev wrote:
> 
> >> But seriously - what about just disallowing non-O_DIRECT opens together
> >> with O_DIRECT ones ?
> >>   
> > Please do not create a new local DOS attack.
> > I open some important file, say /etc/resolv.conf
> > with O_DIRECT and just sit on the open handle.
> > Now nobody else can open that file because
> > it is "busy" with O_DIRECT ?
> 
> Suspend O_DIRECT access while non-O_DIRECT-fds are open, fdatasync on close?

.. then any user can impact the operation, performance and reliability
of the database application of another user... sounds like plugging one
hole by making a bigger hole ;)


