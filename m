Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290072AbSAXUEA>; Thu, 24 Jan 2002 15:04:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290060AbSAXUDk>; Thu, 24 Jan 2002 15:03:40 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26632 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S290032AbSAXUD2>;
	Thu, 24 Jan 2002 15:03:28 -0500
Message-ID: <3C50688B.E87B421F@mandrakesoft.com>
Date: Thu, 24 Jan 2002 15:03:23 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Oliver Xymoron <oxymoron@waste.org>
CC: Linux-Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: RFC: booleans and the kernel
In-Reply-To: <Pine.LNX.4.44.0201241313420.2839-100000@waste.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Xymoron wrote:
> On Thu, 24 Jan 2002, Jeff Garzik wrote:
> > Where variables are truly boolean use of a bool type makes the
> > intentions of the code more clear.  And it also gives the compiler a
> > slightly better chance to optimize code [I suspect].
> 
> Unlikely. The compiler can already figure this sort of thing out from
> context.

X, true, and false are of type int.
If one tests X==false and then later on tests X==true, how does the
compiler know the entire domain has been tested?  With a boolean, it
would.  Or a switch statement... if both true and false are covered,
there is no need for a 'default'.  Similar arguments apply for
enumerated types.

-- 
Jeff Garzik      | "I went through my candy like hot oatmeal
Building 1024    |  through an internally-buttered weasel."
MandrakeSoft     |             - goats.com
