Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262467AbSJETij>; Sat, 5 Oct 2002 15:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262475AbSJETij>; Sat, 5 Oct 2002 15:38:39 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:32241 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262467AbSJETib>; Sat, 5 Oct 2002 15:38:31 -0400
Subject: Re: [PATCH 2.2] i386/dmi_scan updates
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jean Delvare <khali@linux-fr.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021005193506.641E162D05@mallaury.noc.nerim.net>
References: <20021005193506.641E162D05@mallaury.noc.nerim.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 05 Oct 2002 20:52:59 +0100
Message-Id: <1033847579.4441.16.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-10-05 at 22:36, Jean Delvare wrote:
>  - Stop skipping DMI entries when type is less than those of the
>    previous entry. I could see no reason for doing this.

Fixes crashes on certain vendors hardware. It shouldnt be needed,
however in the real world it proves to be a rather essential heuristic.
DMidecode doesnt do it because in userspace I dont mind spewing crap to
show a user a problem.

>  - Verify the DMI entry point structure checksum.
>  - Start looking for the DMI entry point from 0xF0000, not 0xE0000.

Looks ok

>  - Fix an off-by-one error causing the last address scanned being
>    0x100000, not 0xFFFF0 as it should.

Yep

>  - Do not display the DMI version if it would be 0.0.
>  - Remove senseless tests in dump (debug) code.

These are also not senseless. Not everyone seems to use the proper null
string, sometimes you get spaces too


The technical changes look right, and in theory all of it does. In
practice I'd rather see a patch that kept the rule of thumb about order
and the ' ' check

