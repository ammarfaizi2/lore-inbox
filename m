Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932648AbVKXTmg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932648AbVKXTmg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 14:42:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932649AbVKXTmg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 14:42:36 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:27123 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932648AbVKXTmf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 14:42:35 -0500
From: Junio C Hamano <junkio@cox.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andreas Ericsson <ae@op5.se>, Ed Tomlinson <tomlins@cam.org>,
       git@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.15-rc2
References: <Pine.LNX.4.64.0511191934210.8552@g5.osdl.org>
	<200511240737.59153.tomlins@cam.org> <4385BAFC.7070906@op5.se>
	<Pine.LNX.4.64.0511241037400.13959@g5.osdl.org>
Date: Thu, 24 Nov 2005 11:42:33 -0800
In-Reply-To: <Pine.LNX.4.64.0511241037400.13959@g5.osdl.org> (Linus Torvalds's
	message of "Thu, 24 Nov 2005 10:44:14 -0800 (PST)")
Message-ID: <7v4q61suhi.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> (This is in no way really fundamental, and the server could cache the 
> packs it generates for initial clones, but that isn't implemented yet, and 
> probably won't be for some times).

Performance perceived by cloners is helped by

    $ mkdir -p .git/pack-cache
    $ git-rev-list --objects --all | git-pack-objects .git/pack-cache/pack

on the server side.  This exact example of preparing by the
repository maintainer is optimizing for a wrong case, and I do
not think it is worth doing in practice, but this will give you
the lower bound when server side cache is implemented to do it
on demand.



