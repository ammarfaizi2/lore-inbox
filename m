Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261806AbVBXFbt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261806AbVBXFbt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 00:31:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261820AbVBXFbt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 00:31:49 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:60322 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261806AbVBXFbp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 00:31:45 -0500
Date: Thu, 24 Feb 2005 05:31:06 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: "Ammar T. Al-Sayegh" <ammar@kunet.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at mm/rmap.c:483!
In-Reply-To: <005e01c519f8$65ba5020$7101a8c0@shrugy>
Message-ID: <Pine.LNX.4.61.0502240512330.5427@goblin.wat.veritas.com>
References: <009d01c519e8$166768b0$7101a8c0@shrugy> 
    <Pine.LNX.4.61.0502232108500.14780@goblin.wat.veritas.com> 
    <005e01c519f8$65ba5020$7101a8c0@shrugy>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Feb 2005, Ammar T. Al-Sayegh wrote:
> ----- Original Message ----- From: "Hugh Dickins" <hugh@veritas.com>
> > though quite possibly you cannot afford
> > such experiments on this server, and will revert to 2.4 for now.
> 
> The problem is that my server is already in production
> mode. I'm running great portion of my business on it,
> where there is very little tolerance for downtime.

I feared as much.

> Because the server is located in a remote datacenter,
> every time it goes down it takes several hours to have
> someone sent up there to manually reboot it for a hefty
> emergency fee. So this bug has already cost me a lot of
> money, and I'm worried that it will cost me a lot of my
> clients as well if it persists.

I'm very sorry for that.

> Remote hands are rather expensive, so it will cost me
> $100/hr to have someone runs memtest86 on my server
> since I can't perform it remotely. I'll do it though
> since that's your recommendation for the time being.
> Hope it will not take more than an hour to run the
> test, and hope it turns out as bad memory modules as
> you expect because I hate to downgrade after all the
> time and money I expended on the upgrade.

One hour will be enough if it does find a problem in that time,
worth a shot; but not enough to give confidence in the memory
if it does not find one, 12 hours better.  I actually wonder
whether rmap.c:483 is the best memory tester (serious answer
would be, in some cases yes, but not in all).

Do let me know.  If I can find time to rejig the debug patch
against your kernel, it would itself keep your server running,
replacing the BUG_ON by printks and safety.  But without knowing
what it will report, I can't judge how satisfactory that would
be (and it's unlikely to lead us to the final answer in one go).

Hugh
