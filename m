Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264780AbTF3OZf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 10:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264898AbTF3OZb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 10:25:31 -0400
Received: from vdp152.ath06.cas.hol.gr ([195.97.121.153]:11648 "EHLO
	pfn1.pefnos") by vger.kernel.org with ESMTP id S264780AbTF3OWv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 10:22:51 -0400
From: "P. Christeas" <p_christ@hol.gr>
To: Thomas Molina <tmolina@copper.net>
Subject: Re: Synaptics support kills my mouse
Date: Mon, 30 Jun 2003 17:37:27 +0300
User-Agent: KMail/1.5
Cc: Arkadiusz Miskiewicz <arekm@pld-linux.org>,
       lkml <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0306291241220.1007-100000@lap.molina>
In-Reply-To: <Pine.LNX.4.44.0306291241220.1007-100000@lap.molina>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200306300001.38039.p_christ@hol.gr>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Molina wrote:
> On Thu, 26 Jun 2003, P. Christeas wrote:
> > It is true, 2.5.73 unconditionally detects and tries to use the Syn.
> > Touchpad in 'absolute mode'. I wouldn't blame the authors of the module,
> > however. They are already doing a great job :).
> >
> > I 've read the code to see what's wrong and found that the problem is
> > that the Touchpad itself doesn't report any data to the PS/2 port. The
> > code still looks conforming to the specs.
> > However, you shouldn't give up 2.5.73 because of that. You can still use
> > the PS/2 compatibility mode
> >  o Compile the ps mouse as a module "psmouse"
> >  o Arrange so that the module is loaded with the option "psmouse_noext=1"
> >  o Have gpm and X (you can even use both of them) read /dev/input/mice as
> > an exps2 or imps2 mouse (Intellimouse Explorer PS/2) .
>
> Further update.  I can get the same effect/workaround by making the mouse
> support built in (my preference) and specifying the above option on the
> kernel options line.

You can, but I wouldn't recommend that. Having a module allows you to change 
the behaviour runtime (even inside X). 


