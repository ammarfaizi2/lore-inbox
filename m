Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261650AbVBWWrF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261650AbVBWWrF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 17:47:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261628AbVBWWpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 17:45:22 -0500
Received: from kunet.com ([69.26.169.26]:61198 "EHLO kunet.com")
	by vger.kernel.org with ESMTP id S261647AbVBWWic (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 17:38:32 -0500
Message-ID: <005e01c519f8$65ba5020$7101a8c0@shrugy>
From: "Ammar T. Al-Sayegh" <ammar@kunet.com>
To: "Hugh Dickins" <hugh@veritas.com>
Cc: <linux-kernel@vger.kernel.org>
References: <009d01c519e8$166768b0$7101a8c0@shrugy> <Pine.LNX.4.61.0502232108500.14780@goblin.wat.veritas.com>
Subject: Re: kernel BUG at mm/rmap.c:483!
Date: Wed, 23 Feb 2005 17:38:23 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message ----- 
From: "Hugh Dickins" <hugh@veritas.com>
To: "Ammar T. Al-Sayegh" <ammar@kunet.com>
Cc: <linux-kernel@vger.kernel.org>
Sent: Wednesday, February 23, 2005 4:31 PM
Subject: Re: kernel BUG at mm/rmap.c:483!


> On Wed, 23 Feb 2005, Ammar T. Al-Sayegh wrote:
>> 
>> Any suggestion on what else I can do to mitigate this
>> problem?
> 
> The first thing to do is to give memtest86 a good (say
> overnight) run.  Many of the rmap.c BUG reporters have
> subsequently found memtest86 failures, and we believe those
> instances are accounted for by bad memory.  And if that's so
> in your case, you don't really want to be running 2.4 on it.
> 
> But not all cases could be accounted in that way.  If you
> report back that memtest86 ran cleanly, then I'll have to
> rework a debug patch against your Fedora RC3 kernel to try
> to give us more info - though quite possibly you cannot afford
> such experiments on this server, and will revert to 2.4 for now.

The problem is that my server is already in production
mode. I'm running great portion of my business on it,
where there is very little tolerance for downtime.
Because the server is located in a remote datacenter,
every time it goes down it takes several hours to have
someone sent up there to manually reboot it for a hefty
emergency fee. So this bug has already cost me a lot of
money, and I'm worried that it will cost me a lot of my
clients as well if it persists.

Remote hands are rather expensive, so it will cost me
$100/hr to have someone runs memtest86 on my server
since I can't perform it remotely. I'll do it though
since that's your recommendation for the time being.
Hope it will not take more than an hour to run the
test, and hope it turns out as bad memory modules as
you expect because I hate to downgrade after all the
time and money I expended on the upgrade.


-ammar

