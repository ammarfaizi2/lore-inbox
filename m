Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750742AbWG2MY1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742AbWG2MY1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 08:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750784AbWG2MY0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 08:24:26 -0400
Received: from gepetto.dc.ltu.se ([130.240.42.40]:55548 "EHLO
	gepetto.dc.ltu.se") by vger.kernel.org with ESMTP id S1750742AbWG2MY0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 08:24:26 -0400
Message-ID: <1154175570.44cb5252d3f09@portal.student.luth.se>
Date: Sat, 29 Jul 2006 14:19:30 +0200
From: ricknu-0@student.ltu.se
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Jeff Garzik <jeff@garzik.org>,
       Alexey Dobriyan <adobriyan@gmail.com>,
       Vadim Lobanov <vlobanov@speakeasy.net>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Shorty Porty <getshorty_@hotmail.com>,
       Peter Williams <pwil3058@bigpond.net.au>, Michael Buesch <mb@bu3sch.de>,
       Pekka Enberg <penberg@cs.helsinki.fi>,
       Stefan Richter <stefanr@s5r6.in-berlin.de>, larsbj@gullik.net,
       Michael Buesch <mb@bu3sch.de>, Paul Jackson <pj@sgi.com>,
       Josef Sipek <jsipek@fsl.cs.sunysb.edu>,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>,
       Nicholas Miell <nmiell@comcast.net>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Lars Noschinski <cebewee@gmx.de>
Subject: [PATCH 0/2] A generic boolean-type
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
X-Originating-IP: 130.240.42.170
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Here is the first "real" patch to make a generic boolean-type.
Andrew, would you please pick this one up?

First patch:
The boolean is named "bool", this because calling it "boolean" seems long (int
and integer) and not "BOOL", because it is a typedef and not a #define.


The patch also defines aliases to 0 and 1, called "false" and "true".
There has been some who do not want the true and false, but since it is just a
value and not bundled with the boolean type, it is up to the programmer which to
use. Also a quick check:

find . -name *.[chS] | xargs grep "define FALSE" | grep -v "FALSE_" | wc -l
55

tells us there seems to be some who like false and true (and a need for a common
definition, as Andrew attemted).


Secound patch:
Just a "cleanup" of files with common definitions of bool/false/true.


These patches has been applied on the current Linus git-tree and compile-tested.

Hopefully, this patch will be picked up by someone and then the real work can
start, converting those files who uses booleans (and/or false/true). This would
most likely occure at kernel-janitors.

Till next time
/Richard Knutsson

PS
If you do not want to be CC'ed, please tell and I will remove your address.
DS

