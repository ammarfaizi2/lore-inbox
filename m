Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261718AbUC0Kjt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 05:39:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261660AbUC0Kjt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 05:39:49 -0500
Received: from postfix4-2.free.fr ([213.228.0.176]:60841 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S261718AbUC0Kjr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 05:39:47 -0500
To: Ben Collins <bcollins@debian.org>
Cc: Johan FISCHER <linux@fischaz.com>, linux-kernel@vger.kernel.org
Subject: Re: [Panic] ieee1394 HD when moving files
X-PGP-KeyID: 0xF22A794E
X-PGP-Fingerprint: 5854 AF2B 65B2 0E96 2161  E32B 285B D7A1 F22A 794E
From: Vincent Bernat <bernat@free.fr>
In-Reply-To: <20040324105457.GZ2255@phunnypharm.org> (Ben Collins's message
 of "Wed, 24 Mar 2004 05:54:57 -0500")
References: <20040324195300.1q8sc0gcckooc4os@webmail.fischaz.com>
	<20040324105457.GZ2255@phunnypharm.org>
Organization: Khabale Inc
Date: Sat, 27 Mar 2004 11:39:45 +0100
Message-ID: <m3u10a3766.fsf@neo.loria>
User-Agent: Gnus/5.110002 (No Gnus v0.2) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OoO En cette fin de  matinée radieuse du  mercredi 24 mars 2004,  vers
11:54, Ben Collins <bcollins@debian.org> disait:

>> When moving a file >300Mo to my external Hard drive (connected to the ieee1394
>> port), The kernel sytematically panic and crashed with the same error.
>> 
>> The problem seems to come from the DMA part of the OHCI1394 driver and affect
>> the kernel above version 2.6.2 (i'll try the 2.6.3 if I have some times but I'm
>> almost sure the 2.6.2 is the last version to work).

> This is fixed if you use 2.6.5-rc2 + our SVN repo.

I have a similar problem on Linux PPC. With a 2.6.5-rc2 + your SVN
repo, I get :

,----
| ieee1394: sbp2: aborting sbp2 command
| 0x2a 00 02 d5 5f 60 00 00 80 00 
| ieee1394: sbp2: aborting sbp2 command
| 0x2a 00 02 d5 62 e0 00 00 80 00 
| ieee1394: sbp2: sbp2util_node_write_no_wait failed
| ieee1394: sbp2: sbp2util_node_write_no_wait failed
| ieee1394: sbp2: sbp2util_node_write_no_wait failed
| ieee1394: sbp2: sbp2util_node_write_no_wait failed
| ieee1394: sbp2: sbp2util_node_write_no_wait failed
| ieee1394: sbp2: sbp2util_node_write_no_wait failed
| ieee1394: sbp2: sbp2util_node_write_no_wait failed
| ieee1394: sbp2: sbp2util_node_write_no_wait failed
| ieee1394: sbp2: sbp2util_node_write_no_wait failed
`----

The machine is almost freezed then after one minute totally
freezed. All was fine with 2.6.3-ben2 (which was merged in 2.6.4).

It is 100% reproducible. I can enter in the debugger and get a
backtrace. I have to found how to supply System.map since it does not
find it.
-- 
Don't stop with your first draft.
            - The Elements of Programming Style (Kernighan & Plaugher)

