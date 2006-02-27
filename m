Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751494AbWB0Qpd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751494AbWB0Qpd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 11:45:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751496AbWB0Qpd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 11:45:33 -0500
Received: from kanga.kvack.org ([66.96.29.28]:48616 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1751494AbWB0Qpd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 11:45:33 -0500
Date: Mon, 27 Feb 2006 11:39:45 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: David Golombek <daveg@permabit.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.31 hangs, no information on console or serial port
Message-ID: <20060227163944.GB18291@kvack.org>
References: <7yirr8hh0z.fsf@questionably-configured.permabit.com> <20060221152949.GA31273@kvack.org> <7yfym4lqhh.fsf@questionably-configured.permabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7yfym4lqhh.fsf@questionably-configured.permabit.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2006 at 11:24:10AM -0500, David Golombek wrote:
> We're beginning to suspect that a hung loopback NFS mount might be to
> blame, although we can't reproduce this trivially.  Is there anyway in
> which a mount that was behaving badly could affect the kernel in this
> manner?

Loopback NFS can deadlock in trying to free memory when writing back dirty 
pages.  Use mount --bind instead.

		-ben
-- 
"Ladies and gentlemen, I'm sorry to interrupt, but the police are here 
and they've asked us to stop the party."  Don't Email: <dont@kvack.org>.
