Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261298AbUAEPJJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 10:09:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261368AbUAEPJI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 10:09:08 -0500
Received: from ndf144.emirates.net.ae ([217.165.146.144]:56585 "EHLO
	athena.localdomain") by vger.kernel.org with ESMTP id S261298AbUAEPJG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 10:09:06 -0500
Date: Mon, 5 Jan 2004 19:09:58 +0400 (GST)
From: Amit Gurdasani <amitg@alumni.cmu.edu>
X-X-Sender: amitg@athena.localdomain
To: linux-kernel@vger.kernel.org
Subject: Re: Pentium M config option for 2.6
Message-ID: <Pine.LNX.4.56.0401051858540.4783@athena.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

:On Date: Sun, 4 Jan 2004 13:33:58 +0100, Tomas Szepe wrote:
:> > IOW, don't lie to the compiler and pretend P-M == P4
:> > with that -march=pentium4.
:>
:> What do you recommend to use as march then?  There is
:> no pentiumm subarch support in gcc yet;  I was convinced
:> p4 was the closest match.
:
:march=pentium3 is the closest safe choice, at least
:until gcc implements P-M specific support.
:
:/Mikael

Perhaps -mcpu=pentium3 -march=pentium4 would be a good compromise? From the
GCC 3.3 info pages:

`-mcpu=CPU-TYPE'
     Tune to CPU-TYPE everything applicable about the generated code,
     except for the ABI and the set of available instructions. [...]

     While picking a specific CPU-TYPE will schedule things
     appropriately for that particular chip, the compiler will not
     generate any code that does not run on the i386 without the
     `-march=CPU-TYPE' option being used. [...]

`-march=CPU-TYPE'
     Generate instructions for the machine type CPU-TYPE.  The choices
     for CPU-TYPE are the same as for `-mcpu'.  Moreover, specifying
     `-march=CPU-TYPE' implies `-mcpu=CPU-TYPE'.

Amit
