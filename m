Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280456AbRJaTzk>; Wed, 31 Oct 2001 14:55:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280455AbRJaTzV>; Wed, 31 Oct 2001 14:55:21 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:11268 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S280454AbRJaTzQ>; Wed, 31 Oct 2001 14:55:16 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: pre6 BUG oops
Date: Wed, 31 Oct 2001 19:53:37 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <9rpks1$bk$1@penguin.transmeta.com>
In-Reply-To: <3BE03401.406B8585@mandrakesoft.com> <20011031.094112.125896630.davem@redhat.com> <9rpfbj$vrn$1@penguin.transmeta.com> <3BE04338.8F0AF9D4@mandrakesoft.com>
X-Trace: palladium.transmeta.com 1004558148 16363 127.0.0.1 (31 Oct 2001 19:55:48 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 31 Oct 2001 19:55:48 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3BE04338.8F0AF9D4@mandrakesoft.com>,
Jeff Garzik  <jgarzik@mandrakesoft.com> wrote:
>Linus Torvalds wrote:
>> Maybe it's just the page count that is buggered, and we free it too
>> early as a result.  Is this the same machine that had interesting
>> trouble before?
>
>yes, a UP alpha running 2.4.14-pre6, that was described in the false oom
>killer report.

Ok, I think it's the same bug, and that we're just freeing the wrong
page somehow. 

I wonder if the "VALID_PAGE(page)" macro is reliable on alpha? You seem
to be able to trigger this too easily for it to not being something
specific to the setup..

		Linus
