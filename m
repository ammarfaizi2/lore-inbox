Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287348AbSAGXLY>; Mon, 7 Jan 2002 18:11:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287374AbSAGXLO>; Mon, 7 Jan 2002 18:11:14 -0500
Received: from nile.gnat.com ([205.232.38.5]:45258 "HELO nile.gnat.com")
	by vger.kernel.org with SMTP id <S287372AbSAGXLG>;
	Mon, 7 Jan 2002 18:11:06 -0500
From: dewar@gnat.com
To: jtv@xs4all.nl, tim@hollebeek.com
Subject: Re: [PATCH] C undefined behavior fix
Cc: Dautrevaux@microprocess.com, dewar@gnat.com, gcc@gcc.gnu.org,
        linux-kernel@vger.kernel.org, paulus@samba.org,
        trini@kernel.crashing.org, velco@fadata.bg
Message-Id: <20020107231105.A9EBBF2DC3@nile.gnat.com>
Date: Mon,  7 Jan 2002 18:11:05 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<<You're not allowed to be that smart wrt volatile.  If the programmer
says the value might change unpredictably and should not be optimized,
then It Is So and the compiler must respect that even if it determines
It Cannot Possibly Happen.
>>

Indeed, this is the case, for example, you may have a hardware monitor
on the bus, and you are looking for this address, or some external
process may be modifying the location. Or you may legitimately use
volatile so that your debugger works as expected on this location.
