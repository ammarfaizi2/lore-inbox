Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132909AbREHQqT>; Tue, 8 May 2001 12:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132895AbREHQqJ>; Tue, 8 May 2001 12:46:09 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:39690 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S132886AbREHQp6>; Tue, 8 May 2001 12:45:58 -0400
Date: Tue, 8 May 2001 09:45:34 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Brian Gerst <bgerst@didntduck.org>, nigel@nrg.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86 page fault handler not interrupt safe
In-Reply-To: <E14x4zi-0005RA-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0105080944380.1831-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 8 May 2001, Alan Cox wrote:
> 
> I dont see where the alternative patch ensures the user didnt flip the
> direction flag for one

Yeah. 

We might as well just make it "eflags & IF", none of the other flags
should matter (or we explicitly want them cleared).

		Linus

