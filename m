Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270709AbTHFKnn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 06:43:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274935AbTHFKnn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 06:43:43 -0400
Received: from angband.namesys.com ([212.16.7.85]:13995 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S270709AbTHFKnX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 06:43:23 -0400
Date: Wed, 6 Aug 2003 14:43:22 +0400
From: Oleg Drokin <green@namesys.com>
To: Peter Chubb <peter@chubb.wattle.id.au>
Cc: Grant Miner <mine0057@mrs.umn.edu>, linux-kernel@vger.kernel.org
Subject: Re: Filesystem Tests
Message-ID: <20030806104322.GA21673@namesys.com>
References: <3F306858.1040202@mrs.umn.edu> <16176.31324.827466.49836@wombat.chubb.wattle.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16176.31324.827466.49836@wombat.chubb.wattle.id.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Wed, Aug 06, 2003 at 01:47:40PM +1000, Peter Chubb wrote:
> It'd be interesting to add in some read-only operations (e.g., tar to
> /dev/null) because, in general, filesystems trade off expensive writes

If somebody wants to implement this tar test, be aware that gnu tar tries to be extra smart, so
it fstat()s the output and if its equal to /dev/null, then no files are read at all, only
directory tree is traversed.
So one really needs to use something like "tar cf - /path | cat >/dev/null" to get
meaningful results.

Bye,
    Oleg
