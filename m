Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261617AbVCGAYT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261617AbVCGAYT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 19:24:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261609AbVCGAYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 19:24:19 -0500
Received: from coderock.org ([193.77.147.115]:52656 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261605AbVCGAVj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 19:21:39 -0500
Date: Mon, 7 Mar 2005 01:21:33 +0100
From: Domen Puncer <domen@coderock.org>
To: Ralph Corderoy <ralph@inputplus.co.uk>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       isdn4linux@listserv.isdn4linux.de, jlamanna@gmail.com
Subject: Re: [patch 1/8] isdn_bsdcomp.c - vfree() checking cleanups
Message-ID: <20050307002133.GG32564@nd47.coderock.org>
References: <20050306223800.1BBDC1EC90@trashy.coderock.org> <200503070007.j2707n403396@blake.inputplus.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503070007.j2707n403396@blake.inputplus.co.uk>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/05 00:07 +0000, Ralph Corderoy wrote:
> 
> Hi Domen,
> 
> > -		if (db->dict) {
> > -			vfree (db->dict);
> > -			db->dict = NULL;
> > -		}
> > +		vfree (db->dict);
> > +		db->dict = NULL;
> 
> Is it really worth always calling vfree() which calls __vunmap() before
> db->dict is determined to be NULL in order to turn three lines into two?

Four lines into two :-)

> Plus the write to db->dict which might otherwise not be needed.  The old
> code was clear, clean, and fast, no?

Shorter and more readable code is always better, right? And speed really
doesn't seem to be an issue here.


	Domen
