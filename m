Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269310AbUICHhp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269310AbUICHhp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 03:37:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269298AbUICHfS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 03:35:18 -0400
Received: from holomorphy.com ([207.189.100.168]:44674 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269292AbUICHcj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 03:32:39 -0400
Date: Fri, 3 Sep 2004 00:32:30 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, kksx@mail.ru
Subject: Re: INIT hangs with tonight BK pull (2.6.9-rc1+)
Message-ID: <20040903073230.GM3106@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Dmitry Torokhov <dtor_core@ameritech.net>,
	linux-kernel@vger.kernel.org, torvalds@osdl.org, kksx@mail.ru
References: <200409030204.11806.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409030204.11806.dtor_core@ameritech.net>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 03, 2004 at 02:04:11AM -0500, Dmitry Torokhov wrote:
> After doing BK pull last night INIT gets stuck in do_tty_hangup after
> executing rc.sysinit. Was booting fine with pull from 2 days ago...
> Anyone else seeing this?
> I suspect pidhash patch because it touched tty_io.c, but I have not tried
> reverting it as it is getting too late here... So I apologize in advance
> if I am pointing finger at the innocent ;)

Well, I was excited about blowing away 100B from each task but am now
a bit concerned about the semantic impact of the refcounting part of it.
It's unclear what pins an ID while a tty has a reference to it without
the reference counting; Kirill, could you answer this?


-- wli
