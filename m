Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262004AbULPTIl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262004AbULPTIl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 14:08:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261985AbULPTEj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 14:04:39 -0500
Received: from psych.st-and.ac.uk ([138.251.11.1]:49828 "EHLO
	psych.st-andrews.ac.uk") by vger.kernel.org with ESMTP
	id S261989AbULPTDR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 14:03:17 -0500
Subject: Re: file as a directory
From: Peter Foldiak <Peter.Foldiak@st-andrews.ac.uk>
To: Hans Reiser <reiser@namesys.com>
Cc: David Masover <ninja@slaphack.com>, reiserfs-list@namesys.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <41C1D870.2020407@namesys.com>
References: <200411301631.iAUGVT8h007823@laptop11.inf.utfsm.cl>
	 <41ACA7C9.1070001@namesys.com>
	 <1103043518.21728.159.camel@pear.st-and.ac.uk>
	 <41BF21BC.1020809@namesys.com>
	 <1103059622.2999.17.camel@grape.st-and.ac.uk>
	 <41BFC1C5.1070302@slaphack.com>
	 <1103102854.30601.12.camel@pear.st-and.ac.uk>
	 <41C0CF3B.1030705@slaphack.com>  <41C1D870.2020407@namesys.com>
Content-Type: text/plain
Message-Id: <1103223664.2336.335.camel@pear.st-and.ac.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 16 Dec 2004 19:01:04 +0000
Content-Transfer-Encoding: 7bit
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-12-16 at 18:48, Hans Reiser wrote:
> David Masover wrote:
> > Speaking of which, how much speed is lost by starting up a process?
> >
> > The idea of caching is that running
> >
> > cat *; cat *; cat *; cat *; cat *
> >
> > is probably slower than
> >
> > cat * > baz; cat baz; cat baz; cat baz; cat baz; cat baz
> 
> Only for small files where the per file overhead of a read is significant.

But if the glued "file" is a stream (or pipe?) you can't do everything
with it (e.g. seek() ) that you could do with a proper file, right?
You may want to do everything with it that you can do with a proper
file.

