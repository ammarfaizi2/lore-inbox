Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263962AbTDNU3B (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 16:29:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263966AbTDNU3B (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 16:29:01 -0400
Received: from smtp1.wanadoo.fr ([193.252.22.25]:1074 "EHLO
	mwinf0601.wanadoo.fr") by vger.kernel.org with ESMTP
	id S263962AbTDNU26 (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 16:28:58 -0400
From: Duncan Sands <baldrick@wanadoo.fr>
To: "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@digeo.com>
Subject: Re: BUGed to death
Date: Mon, 14 Apr 2003 22:40:41 +0200
User-Agent: KMail/1.5.1
Cc: linux-kernel <linux-kernel@vger.kernel.org>
References: <80690000.1050351598@flay>
In-Reply-To: <80690000.1050351598@flay>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304142240.41999.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 14 April 2003 22:19, Martin J. Bligh wrote:
> Seems all these bug checks are fairly expensive. I can get 1%
> back on system time for kernel compiles by changing BUG to
> "do {} while (0)" to make them all compile away. Profiles aren't
> very revealing though ... seems to be within experimental error ;-(
>
> I was pondering CONFIG_RUN_WILD_NAKED_AND_FREE, but maybe we can
> just nail a few of the hottest path ones instead (I think you did
> a couple already recently). I guess that suggestion isn't much
> use without more profile data though ;-)

You would think that the compiler would consider a branch leading to
ud2 (i.e. BUG()) to be "unlikely", but it doesn't seem to.  Maybe some
improvement can be made there.

All the best,

Duncan.

PS: gcc 3.2.3
