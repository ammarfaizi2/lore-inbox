Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261932AbUFCNY1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261932AbUFCNY1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 09:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262071AbUFCNY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 09:24:27 -0400
Received: from aun.it.uu.se ([130.238.12.36]:65019 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261932AbUFCNY0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 09:24:26 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16575.9858.655475.206533@alkaid.it.uu.se>
Date: Thu, 3 Jun 2004 15:24:18 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Joshua Kwan <joshk@triplehelix.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-rc2-mm1
In-Reply-To: <pan.2004.06.03.00.51.12.405011@triplehelix.org>
References: <20040601021539.413a7ad7.akpm@osdl.org>
	<pan.2004.06.03.00.51.12.405011@triplehelix.org>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joshua Kwan writes:
 > On Tue, 01 Jun 2004 02:15:39 -0700, Andrew Morton wrote:
 > > - merged perfctr.  No documentation though :(
 > 
 > In light of all of the problems with perfctr here, I've gone and done the
 > ifdef work for CONFIG_PERFCTR, presenting an alternative solution to the
 > struct problem...
 > 
 > http://triplehelix.org/~joshk/perfctr.diff

What "all the problems"? There was an issue with warnings on
struct-declared-in-parameter-list when CONFIG_PERFCTR is disabled,
but those are trivial to fix and a fix was posted early on.

Your patch is #ifdef:ing out calls that have explicit no-op stubs
for the !CONFIG_PERFCTR_VIRTUAL case. This shouldn't be needed.
(And you're testing the wrong config option.)

Also _please_ include the maintainer of said code if you think
it has problems.

/Mikael
