Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263795AbTLEByx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 20:54:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263796AbTLEByw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 20:54:52 -0500
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:25041 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S263795AbTLEByw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 20:54:52 -0500
Date: Thu, 4 Dec 2003 17:54:37 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Chuck Lever <cel@citi.umich.edu>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4 read ahead never reads the last page in a file
Message-ID: <20031205015437.GI29119@mis-mike-wstn.matchmail.com>
Mail-Followup-To: Chuck Lever <cel@citi.umich.edu>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.BSO.4.33.0312031800270.24127-100000@citi.umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.BSO.4.33.0312031800270.24127-100000@citi.umich.edu>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 03, 2003 at 06:10:31PM -0500, Chuck Lever wrote:
> generic_file_readahead never reads the last page of a file.  this means
> the last page is always read synchronously by do_generic_file_read.

Has this been fixed in 2.6?  If so, it would improve the speed of mail
servers that use maildir, (I think mbox should be ok, since the data that
was appended has a good chance of still being in memory.  Though, to compute
UIDL for pop3, it has to read the entire mbox file, forcing other mbox users
out of cache, and then evening up performance between the two.  Though this
patch should help maildir more.)
