Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287255AbSAGWFM>; Mon, 7 Jan 2002 17:05:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287244AbSAGWEz>; Mon, 7 Jan 2002 17:04:55 -0500
Received: from cj44686-b.reston1.va.home.com ([24.18.166.90]:61704 "EHLO
	cj44686-b.reston1.va.home.com") by vger.kernel.org with ESMTP
	id <S287235AbSAGWEm>; Mon, 7 Jan 2002 17:04:42 -0500
Date: Mon, 7 Jan 2002 17:28:32 -0500
From: Tim Hollebeek <tim@hollebeek.com>
To: jtv <jtv@xs4all.nl>
Cc: Bernard Dautrevaux <Dautrevaux@microprocess.com>,
        "'dewar@gnat.com'" <dewar@gnat.com>, paulus@samba.org, gcc@gcc.gnu.org,
        linux-kernel@vger.kernel.org, trini@kernel.crashing.org,
        velco@fadata.bg
Subject: Re: [PATCH] C undefined behavior fix
Message-ID: <20020107172832.A1728@cj44686-b.reston1.va.home.com>
Reply-To: tim@hollebeek.com
In-Reply-To: <17B78BDF120BD411B70100500422FC6309E402@IIS000> <20020107224907.D8157@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <20020107224907.D8157@xs4all.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Nothing's taking the pointer's address, so the compiler _will_ be able 
> to prove that (in a sensible universe) no other thread, interrupt, 
> kernel code or Angered Rain God will be able to find our pointer--much 
> less change it.

You're not allowed to be that smart wrt volatile.  If the programmer
says the value might change unpredictably and should not be optimized,
then It Is So and the compiler must respect that even if it determines
It Cannot Possibly Happen.

-Tim
