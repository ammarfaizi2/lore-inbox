Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750797AbWCTLlv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797AbWCTLlv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 06:41:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750787AbWCTLlu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 06:41:50 -0500
Received: from a1819.adsl.pool.eol.hu ([81.0.120.41]:34023 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1750709AbWCTLlt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 06:41:49 -0500
To: matthew@wil.cx
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: DoS with POSIX file locks?
Message-Id: <E1FLIlF-0007zR-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 20 Mar 2006 12:41:21 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unlike open files there doesn't seem to be any limit on the number of
locks being held either globally or by a single process.

Hence an unprivileged process can consume large amounts of unswappable
kernel memory even if there are strict limits on other resources.

Is there a reason why this shouldn't be a problem?

Miklos
