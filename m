Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265134AbUG2T0y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265134AbUG2T0y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 15:26:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263980AbUG2TTJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 15:19:09 -0400
Received: from scrye.com ([216.17.180.1]:9119 "EHLO mail.scrye.com")
	by vger.kernel.org with ESMTP id S264542AbUG2TRd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 15:17:33 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Thu, 29 Jul 2004 13:17:23 -0600
From: Kevin Fenzi <kevin-kernel@scrye.com>
To: linux-kernel@vger.kernel.org
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Subject: Re: [PATCH] reduce swsusp casting
X-Draft-From: ("scrye.linux.kernel" 52985)
References: <1091043436.2871.320.camel@nighthawk>
	<Pine.LNX.4.50.0407281405090.31994-100000@monsoon.he.net>
	<1091049624.2871.464.camel@nighthawk>
	<1091125918.2871.1874.camel@nighthawk>
Message-Id: <20040729191726.5669BBE886@voldemort.scrye.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

>>>>> "Dave" == Dave Hansen <haveblue@us.ibm.com> writes:

Dave> On Wed, 2004-07-28 at 14:20, Dave Hansen wrote:
>> On Wed, 2004-07-28 at 14:07, Patrick Mochel wrote: > I don't
>> understand - have you really tested it or just compile-tested it?
>> > If not, please do try it out for real. There is no reason to be
>> scared of > swsusp, and the more people that use it, the more
>> stable it will get.
>> 
>> I'm not scared, just lazy :) I'll give it a shot.

Dave> Well, I tried with both 2.6.8-rc2-mm1 with and without my patch
Dave> and got the exact same results:

Dave> # echo disk > /sys/power/state Stopping tasks: =

Dave> Then it freezes.

Does it work if you do: 

echo "shutdown" > /sys/power/disk
echo "disk" > /sys/power/state

?

You might also try using the hibernate script to handle unloading
modules, etc: 

http://developer.berlios.de/project/showfiles.php?group_id=1412

(It can handle softwaresuspend2 or the pmdisk /sys/power/state)

kevin
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.8 <http://mailcrypt.sourceforge.net/>

iD8DBQFBCU1G3imCezTjY0ERAmDXAJ9i1uGiL4IatUh+Y+0BQwFeUtQ5oQCffrXM
Q09L8TP9siOomsR5aWWqMsw=
=IRfk
-----END PGP SIGNATURE-----
