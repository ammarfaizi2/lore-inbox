Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318302AbSH1Agr>; Tue, 27 Aug 2002 20:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318318AbSH1Agq>; Tue, 27 Aug 2002 20:36:46 -0400
Received: from adsl-67-117-146-62.dsl.snfc21.pacbell.net ([67.117.146.62]:36869
	"EHLO localhost") by vger.kernel.org with ESMTP id <S318302AbSH1Agq>;
	Tue, 27 Aug 2002 20:36:46 -0400
From: "Stephen C. Biggs" <s.biggs@softier.com>
To: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Date: Tue, 27 Aug 2002 17:40:41 -0700
MIME-Version: 1.0
Subject: Re: Bug in kernel code?
Message-ID: <3D6BB999.5183.3D4AB9@localhost>
In-reply-to: <20020827.172924.107290535.davem@redhat.com>
References: <3D6BB7CA.26619.363BFC@localhost>
X-mailer: Pegasus Mail for Windows (v4.02)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 27 Aug 2002 at 17:29, David S. Miller wrote:

>    From: "Stephen C. Biggs" <s.biggs@softier.com>
>    Date: Tue, 27 Aug 2002 17:32:58 -0700
>    
>    This is a "do while" loop so the first test is always done
>    
> No, a "do while" loop always executes the first iteration.
> What version of the C language do you think we are using?
> 

You're misunderstanding me, I meant that the  first test is done AFTER the first iteration is 
executed, so my fix is correct since, even if order is 0 because at least one iteration of the loop 
is done, and the post decrement makes sure that the test succeeds if order was 0 going into the 
loop.

Changing order to a signed long loses half of the cache entries due to the number being divided by 
2.
