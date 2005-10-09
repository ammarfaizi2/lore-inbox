Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932196AbVJIAVm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932196AbVJIAVm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Oct 2005 20:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932194AbVJIAVl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Oct 2005 20:21:41 -0400
Received: from mailfe07.tele2.fr ([212.247.154.204]:20665 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S932192AbVJIAVl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Oct 2005 20:21:41 -0400
X-T2-Posting-ID: dCnToGxhL58ot4EWY8b+QGwMembwLoz1X2yB7MdtIiA=
Date: Sun, 9 Oct 2005 02:21:30 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: akpm@osdl.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org
Cc: linux-serial@vger.kernel.org
Subject: Re: [patch 3/4] new serial flow control
Message-ID: <20051009002129.GJ5150@bouh.residence.ens-lyon.fr>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	akpm@osdl.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <200501052341.j05Nfod27823@mail.osdl.org> <20050105235301.B26633@flint.arm.linux.org.uk> <20051008222711.GA5150@bouh.residence.ens-lyon.fr> <20051009000153.GA23083@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20051009000153.GA23083@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.9i-nntp
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King, le Sun 09 Oct 2005 01:01:53 +0100, a écrit :
> > How could this look like in userspace?
> 
> I think they should be termios settings - existing programs know how
> to handle termios to get what they want. 

Hence a new field in the termios structure?

There was a discussion about this back in 2000:

http://marc.theaimsgroup.com/?t=96514848800003&r=1&w=2

and more precisely a remind of SVR4's termiox structure with an added
x_hflag:

http://marc.theaimsgroup.com/?l=linux-kernel&m=96523146720678&w=2

I'm not sure about how we'd want to implement that. The SVR4 approach
(orthogonal input/output flow control selection) doesn't seem right to
me: there are really peculiar flow controls that involve both ways. A
mere enumeration of possible methods might be better.

Regards,
Samuel
