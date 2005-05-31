Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261677AbVEaKhu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261677AbVEaKhu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 06:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261708AbVEaKht
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 06:37:49 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:35506 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261677AbVEaKhM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 06:37:12 -0400
Date: Tue, 31 May 2005 12:36:26 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Don't explode on swsusp failure to find swap
Message-ID: <20050531103623.GB1848@elf.ucw.cz>
References: <1117523585.5826.18.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1117523585.5826.18.camel@gaston>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> If we specify a swap device for swsusp using resume= kernel argument and
> that device doesn't exist in the swap list, we end up calling
> swsusp_free() before we have allocated pagedir_save. That causes us to
> explode when trying to free it.
> 
> Pavel, does that look right ?

It looks like a workaround. We should not call swsusp_free in case
device does not exists. Quick look did not reveal where the bug comes
from, can you try to trace it?
								Pavel
