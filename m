Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274127AbRIXSOI>; Mon, 24 Sep 2001 14:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274123AbRIXSN4>; Mon, 24 Sep 2001 14:13:56 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:18193 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S274127AbRIXSNq>; Mon, 24 Sep 2001 14:13:46 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Linux-2.4.10 + ext3
Date: Mon, 24 Sep 2001 18:12:01 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <9ont1h$5fl$1@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0109231142060.1078-100000@penguin.transmeta.com> <1001280620.3540.33.camel@gromit.house> <9om4ed$1hv$1@penguin.transmeta.com> <20010923193008.A13982@vitelus.com>
X-Trace: palladium.transmeta.com 1001355230 24918 127.0.0.1 (24 Sep 2001 18:13:50 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 24 Sep 2001 18:13:50 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010923193008.A13982@vitelus.com>,
Aaron Lehmann  <aaronl@vitelus.com> wrote:
>On Mon, Sep 24, 2001 at 02:06:05AM +0000, Linus Torvalds wrote:
>> We'll merge ext3 soon enough.. As RH seems to start using it more and
>> more, there's more reason to merge it into the standard kernel too.
>> 
>> So don't worry. It will happen.
>
>Kinda OT, but ext3 is often treated more like a new file system than
>an extension of ext2. I'm wondering if this is a good thing. On the
>machines where I use it I have to compile both ext3 and ext2 (because
>it would be foolish to not have ext2 support) into the kernel.

Well, for one thing I absolutely refused during ext3 development to have
ext3 just be an "extension" to ext2. That _was_ how it was originally
thought of, and I very much wanted ext3 to be separate - I strongly felt
that it would be stupid to force people who use ext2 for "stable"
reasons to have to get the extensions (and I hate #ifdef's).

And quite frankly, I don't think we _still_ are at the point where I'd
be comfortable saying that we could just merge them, and everybody would
use the superset of the code.

In five years maybe nobody has any stability worries at all about ext3
code, and we can just drop ext2 and consider it purely a backwards
compatibility extension of ext3.

		Linus
