Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261717AbVDSWpM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261717AbVDSWpM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 18:45:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261715AbVDSWpL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 18:45:11 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:20205 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S261716AbVDSWpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 18:45:05 -0400
To: Petr Baudis <pasky@ucw.cz>
Cc: Steven Cole <elenstev@mesatop.com>, Linus Torvalds <torvalds@osdl.org>,
       Greg KH <greg@kroah.com>, Greg KH <gregkh@suse.de>,
       Git Mailing List <git@vger.kernel.org>, linux-kernel@vger.kernel.org,
       sensors@stimpy.netroedge.com
Subject: Re: [GIT PATCH] I2C and W1 bugfixes for 2.6.12-rc2
References: <20050419043938.GA23724@kroah.com>
	<20050419185807.GA1191@kroah.com>
	<Pine.LNX.4.58.0504191204480.19286@ppc970.osdl.org>
	<426583D5.2020308@mesatop.com> <20050419222609.GE9305@pasky.ji.cz>
From: Junio C Hamano <junkio@cox.net>
Date: Tue, 19 Apr 2005 15:45:02 -0700
In-Reply-To: <20050419222609.GE9305@pasky.ji.cz> (Petr Baudis's message of
 "Wed, 20 Apr 2005 00:26:10 +0200")
Message-ID: <7vpswqpes1.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "PB" == Petr Baudis <pasky@ucw.cz> writes:

PB> I'm wondering if doing

PB> if [ "$(show-diff)" ]; then
PB> 	git diff | git apply
PB> else
PB> 	checkout-cache -f -a
PB> fi

PB> would actually buy us some time; or, how common is it for people to have
PB> no local changes whatsoever, and whether relative slowdown of additional
PB> show-diff to git diff would actually matter.

"show-diff -s" perhaps.  Also wouldn't it be faster to pipe
show-diff output (not git diff output) to patch (not git apply)?


