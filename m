Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264602AbUAVTU2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 14:20:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264933AbUAVTU2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 14:20:28 -0500
Received: from ore.jhcloos.com ([64.240.156.239]:39172 "EHLO ore.jhcloos.com")
	by vger.kernel.org with ESMTP id S264602AbUAVTUY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 14:20:24 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: PATCH: Shutdown IDE before powering off.
From: "James H. Cloos Jr." <cloos@jhcloos.com>
In-Reply-To: <200401220813.i0M8DX4Q000511@81-2-122-30.bradfords.org.uk> (John
 Bradford's message of "Thu, 22 Jan 2004 08:13:33 GMT")
References: <1074735774.31963.82.camel@laptop-linux>
	<20040121234956.557d8a40.akpm@osdl.org>
	<200401220813.i0M8DX4Q000511@81-2-122-30.bradfords.org.uk>
Date: Thu, 22 Jan 2004 14:19:58 -0500
Message-ID: <m3y8rzlrj5.fsf@lugabout.jhcloos.org>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "John" == John Bradford <john@grabjohn.com> writes:

>> This spins down the disk(s) when you're just doing do a reboot.
>> That's fairly irritating and could affect reboot times if one has
>> many disks.

John> I think it is an attempt to force some broken drives to flush
John> their cache, but I wonder whether it will simply move the
John> problem from one set of broken drives to another :-).

It will.  I've had to work with a few drives or drive combos over
the years that would not spin up reliably.  It was vital to keep
them spinning once they were (all) up.  Adding this would make
reboot unnecessarily unuseable in such cases.  Perhaps just
flush, pause, flush would work as well?

Or even the logical equivilent to sync;sync;sync;reboot?

-JimC

