Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750912AbVLYUnQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750912AbVLYUnQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Dec 2005 15:43:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750917AbVLYUnQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Dec 2005 15:43:16 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:65248 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750900AbVLYUnQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Dec 2005 15:43:16 -0500
Date: Sun, 25 Dec 2005 20:43:13 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Kees Cook <kees@outflux.net>
Cc: James Lamanna <jlamanna@gmail.com>, linux-kernel@vger.kernel.org,
       trivial@kernel.org
Subject: Re: [PATCH] lib: zlib_inflate "r.base" uninitialized compile warnings
Message-ID: <20051225204313.GD27946@ftp.linux.org.uk>
References: <aa4c40ff0512251208j46e5de99o51e8d18f5542e9a2@mail.gmail.com> <20051225203531.GN18040@outflux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051225203531.GN18040@outflux.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 25, 2005 at 12:35:32PM -0800, Kees Cook wrote:
> On Sun, Dec 25, 2005 at 12:08:00PM -0800, James Lamanna wrote:
> > What version of gcc are you using?
> 
> gcc (GCC) 4.0.3 20051201 (prerelease) (Debian 4.0.2-5)
> 
> > Looks like a gcc bug that was fixed?
> 
> I guess it's been introduced.  ;)

4.0.x is very bad in that area - it's crying "wolf" a _lot_ and genuine
cases of uninitialized variables being used are drowning in the noise;
compared to 3.x it's a serious regression.
