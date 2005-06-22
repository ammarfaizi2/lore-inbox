Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262708AbVFVDlD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262708AbVFVDlD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 23:41:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262566AbVFVDh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 23:37:28 -0400
Received: from smtp.osdl.org ([65.172.181.4]:7062 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262563AbVFVDgq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 23:36:46 -0400
Date: Tue, 21 Jun 2005 20:36:24 -0700
From: Andrew Morton <akpm@osdl.org>
To: Stas Sergeev <stsp@aknet.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] spinlock cleanup
Message-Id: <20050621203624.0e2f48f9.akpm@osdl.org>
In-Reply-To: <42B8D9FF.1070000@aknet.ru>
References: <42B8D9FF.1070000@aknet.ru>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stas Sergeev <stsp@aknet.ru> wrote:
>
> Here is another attempt to
>  remove the "extern i8253_lock"
>  from the C files.
>  It now uses the same #ifdefs for
>  including the header and using
>  the lock, so it hopefully no
>  longer breaks the compilation.
>  Does it look good this time?

Adding ifdefs around #includes is a bit unsightly - it also increases the
possibility that the build will break when .configs are changed.

Is it not possible to find an appropriate arch-specific header file for the
declaration?
