Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932113AbWGXKgI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113AbWGXKgI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 06:36:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932112AbWGXKgI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 06:36:08 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:18564
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S932110AbWGXKgH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 06:36:07 -0400
Message-ID: <44C4A293.8090207@lsrfire.ath.cx>
Date: Mon, 24 Jul 2006 12:36:03 +0200
From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: Tomasz Torcz <zdzichu@irc.pl>
CC: linux-kernel@vger.kernel.org, git@vger.kernel.org,
       Junio C Hamano <junkio@cox.net>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: Can't clone Linus tree
References: <20060724080752.GA8716@irc.pl> <44C4992E.3070706@lsrfire.ath.cx>
In-Reply-To: <44C4992E.3070706@lsrfire.ath.cx>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Tomasz Torcz schrieb:
>> %  git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git linux-git
>> fatal: packfile '/home/zdzichu/linux-git/.git/objects/pack/tmp-1jI4AH' SHA1 mismatch
>> error: git-fetch-pack: unable to read from git-index-pack
>> error: git-index-pack died with error code 128
>> fetch-pack from 'git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git' failed.

Ah, I just saw this is a known problem and there's a patch by
Matthias Lederhofer, which Junio just accepted, I think (the
mail with subject "[PATCH] upload-pack: fix timeout in
create_pack_file)" on the git mailing list.

The problem is apparently that the server expects you (wrongly)
to finish your download session within ten minutes.  Until the
server is fixed you can use rsync:// for the initial clone and
git:// for smaller updates.

René
