Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317306AbSGTAoL>; Fri, 19 Jul 2002 20:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317308AbSGTAoK>; Fri, 19 Jul 2002 20:44:10 -0400
Received: from p50887F04.dip.t-dialin.net ([80.136.127.4]:64394 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S317306AbSGTAoJ>; Fri, 19 Jul 2002 20:44:09 -0400
Date: Fri, 19 Jul 2002 18:46:57 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: John Levon <movement@marcelothewonderpenguin.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: kbuild - building a module/target from multiple directories
In-Reply-To: <20020720002521.GA34954@compsoc.man.ac.uk>
Message-ID: <Pine.LNX.4.44.0207191845240.3378-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 20 Jul 2002, John Levon wrote:
> With kbuild in 2.5, how do I specify that a module/target is to be built of
> object files and sub-directories ?
> 
> The "obvious" approach :
> 
> obj-$(CONFIG_BLAH) := blah.o
> 
> blah-objs := blah_init.o blahstuff/
> 
> doesn't work. Is there an example of a module doing this ?

What about:

blah/Makefile:

blah-objs := blah_init.o blahstuff/blahstuff.o

blah/blahstuff/Makefile:

blahstuff-objs := blah_didel.o blah_dadel.o blah_dumm.o

?

							Regards,
							Thunder
-- 
(Use http://www.ebb.org/ungeek if you can't decode)
------BEGIN GEEK CODE BLOCK------
Version: 3.12
GCS/E/G/S/AT d- s++:-- a? C++$ ULAVHI++++$ P++$ L++++(+++++)$ E W-$
N--- o?  K? w-- O- M V$ PS+ PE- Y- PGP+ t+ 5+ X+ R- !tv b++ DI? !D G
e++++ h* r--- y- 
------END GEEK CODE BLOCK------

