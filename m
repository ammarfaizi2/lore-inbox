Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317526AbSFLMid>; Wed, 12 Jun 2002 08:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317693AbSFLMic>; Wed, 12 Jun 2002 08:38:32 -0400
Received: from imr1.ericy.com ([208.237.135.240]:55480 "EHLO imr1.ericy.com")
	by vger.kernel.org with ESMTP id <S317526AbSFLMic>;
	Wed, 12 Jun 2002 08:38:32 -0400
Message-ID: <7B2A7784F4B7F0409947481F3F3FEF8303A070D5@eammlnt051.lmc.ericsson.se>
From: "Philippe Veillette (LMC)" <Philippe.Veillette@ericsson.ca>
To: "'Andi Kleen'" <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: RE: sk->socket is invalid in tcp stack
Date: Wed, 12 Jun 2002 08:38:29 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2655.55)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> It likely did receive to a time-wait socket. time-wait buckets are 
> "inherited" by hand from struct sock and live in similar hash tables, 
> but only some fields at the beginning are valid. Yes, it's 
> rather ugly, but ...
> 
> -Andi
> 
Thanks, 

That's what I have found after, the sock is in a time wait state, 
guess i will have to add a check...

Phil
