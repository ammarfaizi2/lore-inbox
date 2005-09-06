Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750884AbVIFVk4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750884AbVIFVk4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 17:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750843AbVIFVk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 17:40:56 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:43117 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S1750833AbVIFVkz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 17:40:55 -0400
Date: Tue, 6 Sep 2005 23:41:33 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: "Budde, Marco" <budde@telos.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kbuild & C++
Message-ID: <20050906214133.GA18223@mars.ravnborg.org>
References: <809C13DD6142E74ABE20C65B11A2439809C4BD@www.telos.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <809C13DD6142E74ABE20C65B11A2439809C4BD@www.telos.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2005 at 01:23:56PM +0200, Budde, Marco wrote:
> Hi,
> 
> for one of our customers I have to port a Windows driver to
> Linux. Large parts of the driver's backend code consists of
> C++. 
> 
> How can I compile this code with kbuild? The C++ support
> (I have tested with 2.6.11) of kbuild seems to be incomplete /
> not working.

If you really need C++ then creating your own ruleset in the Kbuild file
should do the trick.
Something like:

$(obj)/file.o: $(src)/file.cc

And you must provide rules for .cc -> .o

The link part may prove a bit difficult since you may have to link .c
and C++ code. Again writing your own linker ruler is probarly the way
forward.

I can give at a short look if you send something like a minimum set of
sample files (mixed .c and .C++ where you have tried doing some of the
obvious stuff yourself).

This is not about adding C++ to mainstrem kernel if someone thinks so,
this is just about helping Marco.

	Sam
