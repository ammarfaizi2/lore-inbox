Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964865AbWIKF3L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964865AbWIKF3L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 01:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964867AbWIKF3L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 01:29:11 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:65471 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S964865AbWIKF3J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 01:29:09 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Containers <containers@lists.osdl.org>,
       linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] vt: Make vt_pid a struct pid (making it pid wrap around safe).
References: <m1u03fevvz.fsf@ebiederm.dsl.xmission.com>
Date: Sun, 10 Sep 2006 23:28:09 -0600
In-Reply-To: <m1u03fevvz.fsf@ebiederm.dsl.xmission.com> (Eric W. Biederman's
	message of "Sun, 10 Sep 2006 06:41:52 -0600")
Message-ID: <m1ac57as5y.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Grr.  Here is the other half of my confusion.

The patch:
[PATCH] vt: Rework the console spawning variables.
is fine.

The patch:
[PATCH] vt: Make vt_pid a struct pid (making it pid wrap around safe).
which uses xchg() is racy, and needs to be fixed.

Oleg could you confirm that quick analysis.

Thanks,
Eric
