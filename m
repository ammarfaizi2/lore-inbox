Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287279AbSAGWQn>; Mon, 7 Jan 2002 17:16:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287274AbSAGWQd>; Mon, 7 Jan 2002 17:16:33 -0500
Received: from mxzilla2.xs4all.nl ([194.109.6.50]:58889 "EHLO
	mxzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S287279AbSAGWQW>; Mon, 7 Jan 2002 17:16:22 -0500
Date: Mon, 7 Jan 2002 23:16:20 +0100
From: jtv <jtv@xs4all.nl>
To: Tim Hollebeek <tim@hollebeek.com>
Cc: Bernard Dautrevaux <Dautrevaux@microprocess.com>,
        "'dewar@gnat.com'" <dewar@gnat.com>, paulus@samba.org, gcc@gcc.gnu.org,
        linux-kernel@vger.kernel.org, trini@kernel.crashing.org,
        velco@fadata.bg
Subject: Re: [PATCH] C undefined behavior fix
Message-ID: <20020107231620.H8157@xs4all.nl>
In-Reply-To: <17B78BDF120BD411B70100500422FC6309E402@IIS000> <20020107224907.D8157@xs4all.nl> <20020107172832.A1728@cj44686-b.reston1.va.home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020107172832.A1728@cj44686-b.reston1.va.home.com>; from tim@hollebeek.com on Mon, Jan 07, 2002 at 05:28:32PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2002 at 05:28:32PM -0500, Tim Hollebeek wrote:
> 
> You're not allowed to be that smart wrt volatile.  If the programmer
> says the value might change unpredictably and should not be optimized,
> then It Is So and the compiler must respect that even if it determines
> It Cannot Possibly Happen.

Naturally I hope you're right.  But how does that follow from the Standard?
I have to admit I don't have a copy handy.  :(

Let's say we have this simplified version of the problem:

	int a = 3;
	{
		volatile int b = 10;
		a += b;
	}

Is there really language in the Standard preventing the compiler from
constant-folding this code to "int a = 13;"?


Jeroen

