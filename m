Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932436AbWAGINJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932436AbWAGINJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 03:13:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932453AbWAGINJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 03:13:09 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:62088 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932436AbWAGINI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 03:13:08 -0500
Subject: Re: [patch 4/4] Actually make the f_ops field const
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, aviro@redhat.com
In-Reply-To: <20060107000015.0574c842.akpm@osdl.org>
References: <1136583937.2940.90.camel@laptopd505.fenrus.org>
	 <1136584267.2940.101.camel@laptopd505.fenrus.org>
	 <20060107000015.0574c842.akpm@osdl.org>
Content-Type: text/plain
Date: Sat, 07 Jan 2006 09:13:04 +0100
Message-Id: <1136621584.2936.2.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-01-07 at 00:00 -0800, Andrew Morton wrote:
> Arjan van de Ven <arjan@infradead.org> wrote:
> >
> > Mark the f_ops members of inodes as const, as well as fix the ripple-through
> >  this causes by places that copy this f_ops and then "do stuff" with it.
> >  (some of the "do stuff" is quite unpleasant..)
> 
> Right now is the worst possible time in the kernel cycle to be raising
> large many-file patches like this.  You need to either take a look at
> what's coming in -mm or wait until all the git trees have merged up then do
> the patch against -linus.
> 
> In this case there are mulitple new references to non-const file_operations
> added to Linus's tree by alsa 48 hours ago.

argh things move really fast; I'll redo it immediately

