Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261152AbVCXUhR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbVCXUhR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 15:37:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261160AbVCXUhR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 15:37:17 -0500
Received: from terminus.zytor.com ([209.128.68.124]:6292 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261152AbVCXUhN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 15:37:13 -0500
Message-ID: <424324E4.9000003@zytor.com>
Date: Thu, 24 Mar 2005 12:36:52 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kyle Moffett <mrmacman_g4@mac.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Squashfs without ./..
References: <Pine.LNX.4.61.0503221645560.25571@yvahk01.tjqt.qr> <20050323174925.GA3272@zero> <Pine.LNX.4.62.0503241855350.18295@numbat.sonytel.be> <20050324133628.196a4c41.Tommy.Reynolds@MegaCoder.com> <d1v67l$4dv$1@terminus.zytor.com> <3e74c9409b6e383b7b398fe919418d54@mac.com>
In-Reply-To: <3e74c9409b6e383b7b398fe919418d54@mac.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett wrote:
> 
> IMHO, this is one of those cases where "Be liberal in what you accept
> and strict in what you emit" applies strongly.  New filesystems should
> probably always emit "." and ".." in that order with sane behavior,
> and new programs should probably be able to handle it if they don't. I
> would add ".." and "." to squashfs, just so that it acts like the rest
> of the filesystems on the planet, even if it has to emulate them
> internally.  OTOH, I think that the default behavior of find is broken
> and should probably be fixed, maybe by making the default use the full
> readdir and optionally allowing a -fast option that optimizes the
> search using such tricks.
> 

Note that Linux always accepts . and .. so it's just a matter of making 
them appear in readdir.

	-hpa
