Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261422AbVA1DDL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261422AbVA1DDL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 22:03:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261415AbVA1DCk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 22:02:40 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:35036 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261419AbVA1DCf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 22:02:35 -0500
To: linux-kernel@vger.kernel.org
Subject: Correct way to release get_user_pages()?
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <roland@topspin.com>
Date: Thu, 27 Jan 2005 19:02:28 -0800
Message-ID: <52pszqw917.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 28 Jan 2005 03:02:31.0869 (UTC) FILETIME=[CF1C56D0:01C504E5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reading through the tree, I see that some callers of get_user_pages()
release the pages that they got via put_page(), and some callers use
page_cache_release().  Of course <linux/pagemap.h> has

	#define page_cache_release(page)      put_page(page)

so this is really not much of a difference, but I'd like to know which
is considered better style.  Any opinions?

Thanks,
  Roland

