Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288685AbSAIBUG>; Tue, 8 Jan 2002 20:20:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288689AbSAIBT5>; Tue, 8 Jan 2002 20:19:57 -0500
Received: from nile.gnat.com ([205.232.38.5]:43504 "HELO nile.gnat.com")
	by vger.kernel.org with SMTP id <S288685AbSAIBTr>;
	Tue, 8 Jan 2002 20:19:47 -0500
From: dewar@gnat.com
To: jamagallon@able.es, jtv@xs4all.nl
Subject: Re: [PATCH] C undefined behavior fix
Cc: Dautrevaux@microprocess.com, dewar@gnat.com, gcc@gcc.gnu.org,
        linux-kernel@vger.kernel.org, paulus@samba.org, tim@hollebeek.com,
        trini@kernel.crashing.org, velco@fadata.bg
Message-Id: <20020109011947.548C4F2FFB@nile.gnat.com>
Date: Tue,  8 Jan 2002 20:19:47 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<<Yes, thank you, that part was obvious already.  The question pertained
to the fact that nobody outside compiler-visible code was being handed
an address for b, and so the compiler could (if it wanted to) prove
under pretty broad assumptions that nobody could *find* b to make the
change in the first place.
>>

Suppose that a hardware emulator is used to change the value of b (IT
knows the address) at the point of:

>     >>>>>>>>> here b changes

The reason was precisely to test a different value for b. This should
work if b is volatile. So the compiler's proof is flawed. The whole
point of volatile is that ALL such proofs are forbidden for volatile
objects.
