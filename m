Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313299AbSDTABd>; Fri, 19 Apr 2002 20:01:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313669AbSDTABd>; Fri, 19 Apr 2002 20:01:33 -0400
Received: from terminus.zytor.com ([64.158.222.227]:35038 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP
	id <S313299AbSDTABc>; Fri, 19 Apr 2002 20:01:32 -0400
Message-ID: <1577.131.107.184.92.1019260888.squirrel@www.zytor.com>
Date: Fri, 19 Apr 2002 17:01:28 -0700 (PDT)
Subject: Re: [PATCH] Re: SSE related security hole
From: "H. Peter Anvin" <hpa@zytor.com>
To: <torvalds@transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0204191637570.20973-100000@home.transmeta.com>
X-Priority: 3
Importance: Normal
X-MSMail-Priority: Normal
Cc: <bgerst@didntduck.org>, <hpa@zytor.com>, <andrea@suse.de>, <ak@suse.de>,
        <linux-kernel@vger.kernel.org>, <jh@suse.cz>
X-Mailer: SquirrelMail (version 1.2.5)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> I get this feeling that Intel screwed up on specifying how to
> initialize this whole state.
>

Indeed.  Logically, FNINIT should have been extended to initialize it all -
- it is a security hole that it doesn't initialize MMX properly.
Alternatively, for SSE only, an INITP instruction could have been added
that an SSE-enabled OS can use at the time OSXFSR or whatever that flag is
called is set.



