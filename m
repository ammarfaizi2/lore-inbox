Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293632AbSEELXH>; Sun, 5 May 2002 07:23:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293680AbSEELXG>; Sun, 5 May 2002 07:23:06 -0400
Received: from mnh-1-03.mv.com ([207.22.10.35]:23045 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S293632AbSEELXG>;
	Sun, 5 May 2002 07:23:06 -0400
Message-Id: <200205051225.HAA01629@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: Guest section DW <dwguest@win.tue.nl>, Gerrit Huizenga <gh@us.ibm.com>,
        linux-kernel@vger.kernel.org,
        user-mode-linux-devel@lists.sourceforge.net,
        user-mode-linux-user@lists.sourceforge.net
Subject: Re: UML is now self-hosting! 
In-Reply-To: Your message of "Sun, 05 May 2002 01:25:05 MST."
             <20020505082505.GE2392@matchmail.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 05 May 2002 07:25:00 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mfedyk@matchmail.com said:
> How would that benefit Apache, and why does is have any use for an
> imbedded kernel?

See http://user-mode-linux.sourceforge.net/slides/wvu2002/wvu2002.htm, which 
are the slides from a talk I gave at WVU and MorLUG in which I explained this
more clearly than I had managed before.  The section that's relevant here
starts at http://user-mode-linux.sourceforge.net/slides/wvu2002/img9.htm

> How would this be better than MOSIX, or other clustering solutions? 

MOSIX (or Compaq's SSI) would certainly be a way of doing it.  It happens
that there's a particularly simple way of doing it with UML.  You'd partition
UML's 'physical' memory between the hosts, and use the fact that those pages
are really virtual to fault them between hosts as needed.  This would perform
particularly badly, but its simplicity appeals to me.

				Jeff

