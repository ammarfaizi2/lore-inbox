Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262458AbTIOHKJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 03:10:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262467AbTIOHKJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 03:10:09 -0400
Received: from vaxjo.synopsys.com ([198.182.60.75]:39632 "EHLO
	vaxjo.synopsys.com") by vger.kernel.org with ESMTP id S262458AbTIOHKA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 03:10:00 -0400
Date: Mon, 15 Sep 2003 09:09:45 +0200
From: Alex Riesen <alexander.riesen@synopsys.COM>
To: bert hubert <ahu@ds9a.nl>, Mo McKinlay <lkml@ekto.ekol.co.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: logging when SIGSEGV is processed?
Message-ID: <20030915070945.GD1091@Synopsys.COM>
Reply-To: alexander.riesen@synopsys.COM
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Mo McKinlay <lkml@ekto.ekol.co.uk>, linux-kernel@vger.kernel.org
References: <20030914111408.GA14514@strawberry.blancmange.org> <20030914171741.GA18627@outpost.ds9a.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030914171741.GA18627@outpost.ds9a.nl>
Organization: Synopsys, Inc.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bert hubert, Sun, Sep 14, 2003 19:17:41 +0200:
> On Sun, Sep 14, 2003 at 12:14:08PM +0100, Mo McKinlay wrote:
> 
> > Admittedly, it might need some shoehorning into some existing setups (i.e.,
> > where the daemon you wish to watch isn't started directly, but by something
> > else), but it wouldn't be too tricky, I'd've thought.
> 
> init receives that stuff if a process has no other parent, I think, so that
> might be a great place.
> 

will not work if the signal received by the child of a daemon, which does
nothing about its status.

Probably ptrace the daemon (following all its children) would server better.
The feature (logging the coredumps) is definitely no needed for
everything, just some suspectables.

