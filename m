Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268678AbTB0EH0>; Wed, 26 Feb 2003 23:07:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269161AbTB0EH0>; Wed, 26 Feb 2003 23:07:26 -0500
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:62884 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S268678AbTB0EHZ>; Wed, 26 Feb 2003 23:07:25 -0500
To: Kasper Dupont <kasperd@daimi.au.dk>
Cc: DervishD <raul@pleyades.net>, Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: About /etc/mtab and /proc/mounts
References: <20030219112111.GD130@DervishD> <3E5C8682.F5929A04@daimi.au.dk>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 27 Feb 2003 13:14:06 +0900
In-Reply-To: <3E5C8682.F5929A04@daimi.au.dk>
Message-ID: <buoy942s6lt.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kasper Dupont <kasperd@daimi.au.dk> writes:
> I don't think you can put all the information from /etc/mtab
> into /proc/mounts without breaking compatibility.

Why?  Since the option syntax is regular, presumably programs simply
ignore options they don't understand.  No?

> My suggestion would be to change it from /etc/mtab to /mtab.d/mtab.

Please, no.  don't pollute the root (_especially_ with little one-use
directories like that).

/var is clearly the right place for this; if /var isn't mounted
initially, I'd suggest that mount should simply not update any file at
that point, and the init-script that mounts /var can be responsible from
propagating information from /proc/mounts to /var/whatever.

-Miles
-- 
"I distrust a research person who is always obviously busy on a task."
   --Robert Frosch, VP, GM Research
