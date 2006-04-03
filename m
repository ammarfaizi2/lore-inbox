Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751721AbWDCP0a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751721AbWDCP0a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 11:26:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751724AbWDCP0a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 11:26:30 -0400
Received: from unthought.net ([212.97.129.88]:23563 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S1751717AbWDCP0a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 11:26:30 -0400
Date: Mon, 3 Apr 2006 17:26:28 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: Trond Myklebust <trond.myklebust@fys.uio.no>, linux-kernel@vger.kernel.org
Subject: Re: NFS client (10x) performance regression 2.6.14.7 -> 2.6.15
Message-ID: <20060403152628.GA14981@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	linux-kernel@vger.kernel.org
References: <1143807770.8096.4.camel@lade.trondhjem.org> <20060331124518.GH9811@unthought.net> <1143810392.8096.11.camel@lade.trondhjem.org> <20060331132131.GI9811@unthought.net> <1143812658.8096.18.camel@lade.trondhjem.org> <20060331140816.GJ9811@unthought.net> <1143814889.8096.22.camel@lade.trondhjem.org> <20060331143500.GK9811@unthought.net> <1143820520.8096.24.camel@lade.trondhjem.org> <20060331160426.GN9811@unthought.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060331160426.GN9811@unthought.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've run a git bisect from 2.6.14 to 2.6.15 to find what broke the NFS
client.

It seems to be the GIT patch: 24aa1fe6779eaddb3e0b1b802585dcf6faf9cc44
that introduces the problem.

Trond, it took me a lot of tries with GIT to narrow this down, because
the problem does not show up consistently. Some times nfsbench would
complete very quickly, but then a second (or third or ...) run would run
slow.

Could I ask you to try: 
 for i in `seq 1 100`; do time ./nfsbench; done
or something like that?

I'm looking through the patch, but to be honest the NFS cache internals
isn't really something I understand... :)

-- 

 / jakob

