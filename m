Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314285AbSDTAVu>; Fri, 19 Apr 2002 20:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314383AbSDTAVt>; Fri, 19 Apr 2002 20:21:49 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:62212 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S314285AbSDTAVs>; Fri, 19 Apr 2002 20:21:48 -0400
Date: Fri, 19 Apr 2002 17:21:12 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Brian Gerst <bgerst@didntduck.org>
cc: "H. Peter Anvin" <hpa@zytor.com>, <andrea@suse.de>, <ak@suse.de>,
        <linux-kernel@vger.kernel.org>, <jh@suse.cz>
Subject: Re: [PATCH] Re: SSE related security hole
In-Reply-To: <3CC0B16F.1050501@didntduck.org>
Message-ID: <Pine.LNX.4.44.0204191714080.6542-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 19 Apr 2002, Brian Gerst wrote:
>
> I don't know about Intel, but the Athlon doesn't appear to save anything
> in the "reserved" areas.

Yes, I think it will work with current CPU's, I'm just worried about
future state extensions.

That said, I personally certainly prefer this approach which is guaranteed
to set as much as possible to a known state, even in the presense of
future extensions. If future extensions don't like loading zeroes, at
least the state will be _consistent_, which on the whole is really the
most important thing.

Applied.

		Linus

