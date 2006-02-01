Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932399AbWBALkr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932399AbWBALkr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 06:40:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932444AbWBALkr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 06:40:47 -0500
Received: from cust8446.nsw01.dataco.com.au ([203.171.93.254]:15323 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S932399AbWBALkq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 06:40:46 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [ 00/10] [Suspend2] Modules support.
To: linux-kernel@vger.kernel.org
Message-Id: <20060201113710.6320.68289.stgit@localhost.localdomain>
Date: Wed,  1 Feb 2006 21:37:10 +1000 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi everyone.

This set of patches represents the core of Suspend2's module support.

Suspend2 uses a strong internal API to separate the method of
determining the content of the image from the method by which it is saved.
The code for determining the content is part of the core of Suspend2, and
transformations (compression and/or encryption) and storage of the pages are
handled by 'modules'.

The name is currently mostly historical, from the time when these components
could be built as kernel modules. That function was dropped to help with
merging, but I'd like to reintroduce it later, since some embedded developers
want to use Suspend2 to improve boot times. If/when that happens, I'll do it
in a way that doesn't require as many exported symbols as was previously
required. For now, though, the name remains, along with a few functions that
are needed for building as modules. My expectation is that merging will take
some time; perhaps by that time, I'll have modular support back in, in a
better form.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

--
Nigel Cunningham   nigel at suspend2 dot net   http://suspend2.net
