Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263131AbTFTOtM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 10:49:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263152AbTFTOtM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 10:49:12 -0400
Received: from camus.xss.co.at ([194.152.162.19]:26643 "EHLO camus.xss.co.at")
	by vger.kernel.org with ESMTP id S263131AbTFTOtK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 10:49:10 -0400
Message-ID: <3EF32223.6000207@xss.co.at>
Date: Fri, 20 Jun 2003 17:02:59 +0200
From: Andreas Haumer <andreas@xss.co.at>
Organization: xS+S
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
CC: Andy Pfiffer <andyp@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.72: wall-clock time advancing too rapidly?
References: <1056039012.3879.5.camel@andyp.pdx.osdl.net> <1056058206.18644.532.camel@w-jstultz2.beaverton.ibm.com>
In-Reply-To: <1056058206.18644.532.camel@w-jstultz2.beaverton.ibm.com>
X-Enigmail-Version: 0.74.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi!

john stultz wrote:
> On Thu, 2003-06-19 at 09:10, Andy Pfiffer wrote:
>
>>I have a uniproc P3-800 system running 2.5.72, and time (from that
>>system's point of view) is racing ahead rapidly.
>>
>>By "racing ahead rapidly", I mean this:
>>
>>	% date ; sleep 60 ; date
>>	Thu Jun 19 09:04:29 PDT 2003
>>	Thu Jun 19 09:05:29 PDT 2003
>>	%
>>
>>returns in 35 seconds (measured with my eyeballs and cheap wristwatch).
>>
>>Has anyone else seen this?
>
>
> Well, variants on a theme. Can I get more hardware info? Is this a
> laptop? Are we running w/ Speed Step?
>
I had this symptom recently on an Asus PR-DLS533 mainboard
(ServerWorks GCLE chipset) with linux-2.4.21 and found out
it happens only if I had BIOS "USB legacy support" enabled.
As soon as I disabled this BIOS option, the phenomenon
disappeard.
For more info look for lkml thread with subject "system clock
speed too high?", Message-ID <3EDBA83B.5050406@xss.co.at>

HTH

- - andreas

- --
Andreas Haumer                     | mailto:andreas@xss.co.at
*x Software + Systeme              | http://www.xss.co.at/
Karmarschgasse 51/2/20             | Tel: +43-1-6060114-0
A-1100 Vienna, Austria             | Fax: +43-1-6060114-71
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE+8yIhxJmyeGcXPhERAoyRAKDD+bmvWsdoHXtsAUnmQpOivdYlRwCfZZox
gofL6W64SQ+Hy8xQMehLeS8=
=GEhC
-----END PGP SIGNATURE-----

