Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261802AbUEVTPh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261802AbUEVTPh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 15:15:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261830AbUEVTPh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 15:15:37 -0400
Received: from cantor.suse.de ([195.135.220.2]:38380 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261802AbUEVTPg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 15:15:36 -0400
Subject: Re: [PATCH] ext3 barrier bits
From: Chris Mason <mason@suse.com>
To: Andrew Morton <akpm@osdl.org>
Cc: arjanv@redhat.com, axboe@suse.de, linux-kernel@vger.kernel.org
In-Reply-To: <20040522013313.6cb15a4b.akpm@osdl.org>
References: <20040521093207.GA1952@suse.de>
	 <20040521023807.0de63c7a.akpm@osdl.org> <20040521100234.GK1952@suse.de>
	 <20040521235044.6160cccb.akpm@osdl.org> <20040522073540.GO1952@suse.de>
	 <20040522011139.01a7da10.akpm@osdl.org>
	 <1085214261.2781.1.camel@laptop.fenrus.com>
	 <20040522013313.6cb15a4b.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1085253331.9467.4982.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 22 May 2004 15:15:32 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-05-22 at 04:33, Andrew Morton wrote:
> Arjan van de Ven <arjanv@redhat.com> wrote:
> >
> > 
> > > - Does the kernel tell you if your disk doesn't supoprt barriers?  ie:
> > >   how does the user know if it's working or not?
> > 
> > ... and how do you know your disk isn't lying and ignoring the barriers?
> > 
> 
> If some benchmark slows down when barriers are enabled then that's a pretty
> good indicator.  I don't know what benchmark that might be though.

synctest -t 20 -n 1 -f dir, should show a performance hit when barriers
are on.

-chris


