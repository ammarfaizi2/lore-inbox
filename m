Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965253AbWHOOLw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965253AbWHOOLw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 10:11:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965372AbWHOOLw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 10:11:52 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27347 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965253AbWHOOLv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 10:11:51 -0400
Date: Tue, 15 Aug 2006 07:11:38 -0700
From: Andrew Morton <akpm@osdl.org>
To: Reiner Herrmann <reiner@reiner-h.de>
Cc: linux-kernel@vger.kernel.org, Miloslav Trmac <mitr@volny.cz>,
       Dmitry Torokhov <dtor@mail.ru>
Subject: Re: 2.6.18-rc4: freeze with wistron_btns driver
Message-Id: <20060815071138.9f11f8f1.akpm@osdl.org>
In-Reply-To: <200608151517.57833.reiner@reiner-h.de>
References: <200608151517.57833.reiner@reiner-h.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Aug 2006 15:17:57 +0200
Reiner Herrmann <reiner@reiner-h.de> wrote:

> After loading the wistron_btns driver in 2.6.18-rc4 and pressing some buttons
> that become enabled by this driver, the kernel suddenly freezes.
> 
> The reason seems to be git-commit c7948989f84ee6e9c68cc643f8c6a635eb7a904b.
> After reversing this patch everything is running fine, except that there
> are again the 'section reference mismath' warnings that have been fixed
> by the commit.

erp.  Pretty much the whole thing needs reverting because global variable
`keymap' ends up pointing at one of those tables.

