Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269786AbUHZW7l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269786AbUHZW7l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 18:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269783AbUHZW7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 18:59:14 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:17025 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S269761AbUHZW6N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 18:58:13 -0400
X-Comment: AT&T Maillennium special handling code - c
Message-ID: <412E69D2.50503@namesys.com>
Date: Thu, 26 Aug 2004 15:53:06 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Rik van Riel <riel@redhat.com>, Diego Calleja <diegocg@teleline.es>,
       jamie@shareable.org, christophe@saout.de,
       vda@port.imtp.ilyichevsk.odessa.ua, christer@weinigel.se,
       spam@tnonline.net, akpm@osdl.org, wichert@wiggy.net, jra@samba.org,
       hch@lst.de, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
References: <Pine.LNX.4.44.0408261607070.27909-100000@chimarrao.boston.redhat.com> <Pine.LNX.4.58.0408261315110.2304@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0408261315110.2304@ppc970.osdl.org>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>
>
>For example, it's likely that most filesystems would _not_ allow linking 
>of a named stream anywhere else.
>
Why?  It is just a file that inherits its stat data and is referenced by 
a concatenation method of its parent directory.  The link will also 
inherit its stat data from the original parent directory.

> And you might not be able to change the 
>permissions or date on the named stream either, since it may or may not 
>have a separate date/permission thing from the container.
>  
>
You should be able to change the permission and data, but when you 
change it, you change it for the whole container.
