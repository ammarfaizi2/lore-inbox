Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264890AbUDWRl6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264890AbUDWRl6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 13:41:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264891AbUDWRl6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 13:41:58 -0400
Received: from thunk.org ([140.239.227.29]:7820 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S264890AbUDWRl5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 13:41:57 -0400
Date: Fri, 23 Apr 2004 13:41:47 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Miquel van Smoorenburg <miquels@cistron.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: File system compression, not at the block layer
Message-ID: <20040423174146.GB5977@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Miquel van Smoorenburg <miquels@cistron.nl>,
	linux-kernel@vger.kernel.org
References: <408951CE.3080908@techsource.com> <c6bjrd$pms$1@news.cistron.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6bjrd$pms$1@news.cistron.nl>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2004 at 05:30:21PM +0000, Miquel van Smoorenburg wrote:
> In article <408951CE.3080908@techsource.com>,
> Timothy Miller  <miller@techsource.com> wrote:
> >Well, why not do the compression at the highest layer?
> >[...] doing it transparently and for all files.
> 
> http://e2compr.sourceforge.net/

It's been done (see the above URL), but given how cheap disk space has
gotten, and how the speed of CPU has gotten faster much more quickly
than disk access has, many/most people have not be interested in
trading off performance for space.  As a result, there are race
conditions in e2compr (which is why it never got merged into
mainline), and there hasn't been sufficient interest to either (a)
forward port e2compr to more recent kernels revisions, or (b) find and
fix the race conditions.

							- Ted


