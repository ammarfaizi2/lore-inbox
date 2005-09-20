Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750711AbVITWva@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750711AbVITWva (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 18:51:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750713AbVITWva
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 18:51:30 -0400
Received: from rwcrmhc14.comcast.net ([204.127.198.54]:21184 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1750711AbVITWv3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 18:51:29 -0400
Message-ID: <43309243.3050100@comcast.net>
Date: Tue, 20 Sep 2005 18:50:43 -0400
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050912)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: linux-kernel@vger.kernel.org
Subject: Re: Hot-patching
References: <43308815.1000200@comcast.net> <200509202221.j8KMLhcr032238@turing-police.cc.vt.edu>
In-Reply-To: <200509202221.j8KMLhcr032238@turing-police.cc.vt.edu>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Valdis.Kletnieks@vt.edu wrote:
> On Tue, 20 Sep 2005 18:07:17 EDT, John Richard Moser said:
> 
> 
>>These bugfixes don't typically change the exported binary interface of
>>the existing functions being corrected, and so it would be feasible to
>>halt all processors and execute an atomic codepath to switch the symbols
>>in the running kernel to point to the replacement functions from the old
>>ones.  If big functions are split up into smaller ones, as long as the
>>interface is the same for all existing functions, it shouldn't matter as
>>well.
> 
> 
> I believe telco switch software has been doing patch-on-the-fly for quite
> a long time.  It's a royal pain in the butt, especially if you have any
> dynamic 'struct foo_ops' lurking.
> 
> And you can't just plop the code in either - let's say the fix includes "add
> a state bit to the 'struct foo_ctl' to track XYZ".  Now you need to think about
> the fact that there's likely kmalloc'ed struct foo_ctl's already out there
> that don't know about this bit.  Hilarity ensues....

In which case you can't make a hot-patch, unless you like watching your
kernel take a crap.

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

    Creative brains are a valuable, limited resource. They shouldn't be
    wasted on re-inventing the wheel when there are so many fascinating
    new problems waiting out there.
                                                 -- Eric Steven Raymond
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDMJJDhDd4aOud5P8RAijUAJ9BPXQoVCeD5EzTXedBGaIz87SjsgCdEN21
6/2BUWcZ4HT4FwSFkWt5OEM=
=WjP8
-----END PGP SIGNATURE-----
