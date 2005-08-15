Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964799AbVHOPC6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964799AbVHOPC6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 11:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964805AbVHOPC6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 11:02:58 -0400
Received: from zproxy.gmail.com ([64.233.162.193]:65390 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964799AbVHOPC5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 11:02:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Z0L3sIjPJqBCrKmI7LdhqIVEtTFCTttGJoVaGem/8vV1xFIuZIw1sv+8RGpDIh9/YC/yoyN4lT4QaDUT0pbYQJsddG9GeTD7kjPPsD9FuQc8eg8TQkU52PTVUbcmYwXCZ63BjR4CdUd2Yas5F7Z/Hc055ISeTIqxzt/WrtvOY40=
Message-ID: <6c58e3190508150802e2cd16@mail.gmail.com>
Date: Mon, 15 Aug 2005 18:02:56 +0300
From: Dror Cohen <dror.xiv@gmail.com>
To: e1000-devel@lists.sourceforge.net
Subject: Re: e1000 6.0.60 problems
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       linville@tuxdriver.com
In-Reply-To: <6c58e319050815061437bc278f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <6c58e319050815061437bc278f@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

some updates:

On 8/15/05, Dror Cohen <dror.xiv@gmail.com> wrote:
> Hello all,
>....
> when using the latest 6.1.16 version of the driver (which doesn't seem
> to have the watch dog fix, but a lot of other fixes) we see similar
> results to our modified version - there are still NETDEV events with
> the "Detected Tx Unit Hang" message followed by the output of the
> registers.

we just had a stuck machine with the 6.1.16 version (again, no console
, had to reboot)
var log messages looks like the one the previous halt (order
allocation failed, from e1000 irq handling). I guess this means the
backporting of the watch dog does indeed help.

> 
> more information can be supplied if needed.
> 
> our questions:
> * Is anyone experiencing similar problems (looks to us alot like: "[
> 955064 ] e1000 freezes Linux with 82544GC (similar to a year-old bug)") ?

forgot the link:
http://sourceforge.net/tracker/index.php?func=detail&aid=955064&group_id=42302&atid=447449

> 
> * Was the watch dog change forgotten, or left out deliberetly ? Does our
> patch seems to be OK ? it is also not present in the latest version (6.1.6).
> 
> * are the allocation problems related in anyway to e1000 problem ?
> 
> ...
> 
> 
> 

since I'm not on the linux-kernel list (but I am on the linux-net and
e1000 lists) please CC
replies to dror at xiv.co.il 

thanks,
Dror
