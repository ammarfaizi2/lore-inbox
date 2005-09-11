Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750828AbVIKTpK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750828AbVIKTpK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 15:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750829AbVIKTpK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 15:45:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:48522 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750828AbVIKTpI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 15:45:08 -0400
Date: Sun, 11 Sep 2005 12:44:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: donate <donate@madrone.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH] make add_taint() inline
Message-Id: <20050911124434.1967ac6e.akpm@osdl.org>
In-Reply-To: <20050911104437.6445ff20.donate@madrone.org>
References: <20050911103757.7cc1f50f.rdunlap@xenotime.net>
	<20050911104437.6445ff20.donate@madrone.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

donate <donate@madrone.org> wrote:
>
> From: donate <donate@madrone.org>

Who is this?

> From: Randy Dunlap <rdunlap@xenotime.net>

>  add_taint() is a trivial function.
>  No need to call it out-of-line, just make it inline and
>  remove its export.

Well, presumably add_taint() was exported to modules for a reason.  If that
reason was valid then this patch requires that `tainted' be exported to
modules too.  And that allows naughty modules to trivially zero it out.

