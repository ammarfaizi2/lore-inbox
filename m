Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261240AbVAaPxJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261240AbVAaPxJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 10:53:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261241AbVAaPxJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 10:53:09 -0500
Received: from rrcs-24-227-247-8.sw.biz.rr.com ([24.227.247.8]:23248 "EHLO
	emachine.austin.ammasso.com") by vger.kernel.org with ESMTP
	id S261240AbVAaPxG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 10:53:06 -0500
Message-ID: <41FE53EA.4010101@ammasso.com>
Date: Mon, 31 Jan 2005 09:51:06 -0600
From: Timur Tabi <timur.tabi@ammasso.com>
Reply-To: linux-kernel@vger.kernel.org
Organization: Ammasso
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: roland@topspin.com, linux-kernel@vger.kernel.org
Subject: Re: Correct way to release get_user_pages()?
References: <52pszqw917.fsf@topspin.com>	<41FA7AE2.10209@ammasso.com> <20050130021017.7ef1c764.akpm@osdl.org>
In-Reply-To: <20050130021017.7ef1c764.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> no...  You should only dirty the page if it was modified, and then use
> set_page_dirty() or set_page_dirty_lock().

If the page was modified, then shouldn't it already be marked dirty?

Also, should I always use set_page_dirty_lock() if I haven't already 
locked the page?


-- 
Timur Tabi
Staff Software Engineer
timur.tabi@ammasso.com
