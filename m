Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277904AbRJRS7B>; Thu, 18 Oct 2001 14:59:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277975AbRJRS6l>; Thu, 18 Oct 2001 14:58:41 -0400
Received: from doorbell.lineo.com ([204.246.147.253]:64499 "EHLO
	thor.lineo.com") by vger.kernel.org with ESMTP id <S277904AbRJRS6j>;
	Thu, 18 Oct 2001 14:58:39 -0400
Message-ID: <3BCF271F.2CDAB9B7@lineo.com>
Date: Thu, 18 Oct 2001 13:01:51 -0600
From: Tim Bird <tbird@lineo.com>
X-Accept-Language: en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: Input on the Non-GPL Modules
In-Reply-To: <Pine.LNX.4.21.0110181113020.9058-100000@wyrm.rakis.net> <20011018183217.A5055@gondor.com> <3bcf0c42.97910140@tony-home> <20011018191539.A5676@gondor.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Niehusmann wrote:
> 
> On Thu, Oct 18, 2001 at 05:08:13PM +0000, Tony Hoyle wrote:
> > This is still a GPL violation, as the small module couldn't then be
> > linked with the proprietary module.  Most companies aren't prepared to
> > get into the legally murky ground that that sort of thing entails.
> 
> Why not? It is obviously allowed to write proprietary modules, as long
> as they dont use GPL-only interfaces.

This is not true from both the standpoint of what Linus has
said and what copyright law says.

Linus made an exception for proprietary modules, but also
made an exception to the exception in the case of modules
providing "essential" functionality.  I don't have his
exact wording, but it was something to the effect that
using dynamic loading purely as a dodge on the GPL was not
kosher.

My belief is that proprietary modules are "allowed" (tolerated
might be a better word), when they meet several criteria
(including but not limited to):
	- another module of the same type is proprietary, and:
		- it is included in kernel.org source, or
		- there is a long-standing precedence for
		proprietary modules of this kind
	- no portion of the kernel which is statically linked
	relies on the loadable module.
	- the module does NOT provide an essential facility
	of the OS (such as sheduling, baseline memory management,
	etc.)

Unfortunately, all of this is fairly nebulous and subjective.

On the second point, copyright law doesn't make the same types
of distinctions on derivative works that programmers appear
prone to make (eg. does it link statically or dynamically?).
Dynamic linking matters a whole lot less for copyright law
than other factors, like whether there are multiple
implementations of the interface available or what the
purpose of the interface is.

Finally, I am NOT a laywer and I'm not Linus.  Take what I
say on this list with a grain of salt.
____________________________________________________________
Tim Bird                                  Lineo, Inc.
Senior VP, Research                       390 South 400 West
tbird@lineo.com                           Lindon, UT 84042
