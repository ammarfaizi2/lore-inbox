Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264811AbSJORYP>; Tue, 15 Oct 2002 13:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264812AbSJORYP>; Tue, 15 Oct 2002 13:24:15 -0400
Received: from host194.steeleye.com ([66.206.164.34]:11019 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S264811AbSJORYO>; Tue, 15 Oct 2002 13:24:14 -0400
Message-Id: <200210151730.g9FHU4f03129@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: James Bottomley <James.Bottomley@SteelEye.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Summit support for 2.5 - now with subarch! [4/5] 
In-Reply-To: Message from "Martin J. Bligh" <mbligh@aracnet.com> 
   of "Mon, 14 Oct 2002 16:35:12 PDT." <2001880782.1034613312@[10.10.2.3]> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 15 Oct 2002 10:30:04 -0700
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > This should really be in a .c file in mach-summit.  I know a single line file 
> > with just a variable in it is a bit strange, but the principle of the subarch 
> > stuff is to have anything subarch specific (which this is) in mach-<subarch>.

> That's pretty pointless for one variable. I think you're taking things
> to ridiculous extremes.

OK, I agree that a single .c file for one variable is very extreme.  I think 
you also would agree with me that if it had been ten variables and an exported 
function then it should live in a separate .c file in the summit specific code.

My concern is that there will come a day when the summit code is enhanced to 
add the extra nine variables and the function.  Since there's nowhere in 
mach-summit to add them, they get added to smpboot.c.  Now we have a go around 
on linux-kernel about why they should be in a separate .c file.

You see the issue: I code by looking at how someone else did it, so if we're 
setting a precedent then it should be done correctly rather than catching and 
correcting a mistake we expect someone will now make.

If you can promise me that summit will never need an extra variable or 
exported function as the code evolves from now until the end of the 
architecture then I can live with summit_x86 in the main line.

James


