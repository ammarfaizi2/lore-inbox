Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261615AbVCGAS5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261615AbVCGAS5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 19:18:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261578AbVCGASB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 19:18:01 -0500
Received: from cmailg1.svr.pol.co.uk ([195.92.195.171]:41478 "EHLO
	cmailg1.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id S261581AbVCGAIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 19:08:01 -0500
Message-Id: <200503070007.j2707n403396@blake.inputplus.co.uk>
To: domen@coderock.org
cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       isdn4linux@listserv.isdn4linux.de, jlamanna@gmail.com
Subject: Re: [patch 1/8] isdn_bsdcomp.c - vfree() checking cleanups 
In-Reply-To: <20050306223800.1BBDC1EC90@trashy.coderock.org> 
Date: Mon, 07 Mar 2005 00:07:48 +0000
From: Ralph Corderoy <ralph@inputplus.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Domen,

> -		if (db->dict) {
> -			vfree (db->dict);
> -			db->dict = NULL;
> -		}
> +		vfree (db->dict);
> +		db->dict = NULL;

Is it really worth always calling vfree() which calls __vunmap() before
db->dict is determined to be NULL in order to turn three lines into two?
Plus the write to db->dict which might otherwise not be needed.  The old
code was clear, clean, and fast, no?

Cheers,


Ralph.

