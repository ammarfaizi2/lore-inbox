Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286779AbSABJRq>; Wed, 2 Jan 2002 04:17:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286815AbSABJRg>; Wed, 2 Jan 2002 04:17:36 -0500
Received: from descartes.noos.net ([212.198.2.74]:22645 "EHLO smtp.noos.fr")
	by vger.kernel.org with ESMTP id <S286779AbSABJRU>;
	Wed, 2 Jan 2002 04:17:20 -0500
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Momchil Velikov <velco@fadata.bg>, Tom Rini <trini@kernel.crashing.org>
Cc: <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [PATCH] mesh: target 0 aborted
Date: Wed, 2 Jan 2002 10:17:10 +0100
Message-Id: <20020102091710.14178@smtp.noos.fr>
In-Reply-To: <20020101234546.GO28513@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <20020101234546.GO28513@cpe-24-221-152-185.az.sprintbbd.net>
X-Mailer: CTM PowerMail 3.1.1 carbon <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> This patch makes mesh.c compile, by adapting it to the new
>> pmac_feature API (ported from the ppc tree).
>>
>> In addition it contains the fix from Thomas Capricelli for the
>> infamous "mesh: target 0 aborted" error, which I've been personally
>> observing since 2.1.13x.
>
>Er, what exactly is this against?  If this is just what's in the
>linuxppc_2_4 tree against current 2.4.18pre, this is either (or will be
>now :)) on BenH's list of things to resend to Marcelo, or there's a
>problem with it still.  If you added in another patch, please re-send
>this vs the linuxppc_2_4 tree.

The up to date mesh driver didn't get into 2.4.18pre1, either I forgot
to send it to Marcelo along with the other PPC patches, or he missed it.

I'll take care of this.

The other patch for getting rid of "target 0 aborted" need some more
review. You seem to just remove the bus reset. That could be made a
driver option in case it really cause trouble, but I suppose the bug
is elsewhere (while beeing triggered by the bus reset).

I'll look into this around next week.

Ben.


