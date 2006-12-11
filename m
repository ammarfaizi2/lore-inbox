Return-Path: <linux-kernel-owner+w=401wt.eu-S1763129AbWLKWBU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763129AbWLKWBU (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 17:01:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763148AbWLKWBU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 17:01:20 -0500
Received: from rwcrmhc13.comcast.net ([216.148.227.153]:48985 "EHLO
	rwcrmhc13.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763129AbWLKWBT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 17:01:19 -0500
Message-ID: <457DD528.1060006@comcast.net>
Date: Mon, 11 Dec 2006 17:01:12 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Thunderbird 1.5.0.8 (X11/20061115)
MIME-Version: 1.0
To: Eric Piel <Eric.Piel@tremplin-utc.net>
CC: Kyle McMartin <kyle@ubuntu.com>, linux-kernel@vger.kernel.org
Subject: Re: noexec=on doesn't work
References: <457B0FD7.2030804@comcast.net> <20061209200323.GA21514@athena.road.mcmartin.ca> <457DB755.1000100@tremplin-utc.net>
In-Reply-To: <457DB755.1000100@tremplin-utc.net>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Eric Piel wrote:
> 12/09/2006 09:03 PM, Kyle McMartin wrote/a écrit:
>> On Sat, Dec 09, 2006 at 02:34:47PM -0500, John Richard Moser wrote:
>>> I have filed this as a distro bug with Ubuntu; it may be their issue, I
>>> haven't dug deep enough to find out.  I am posting this here to disperse
>>> the information breadth-first instead of depth-first, which will shorten
>>> the bug's life cycle if it turns out to be an upstream bug.
>>>
>>
>> NX requires the 64-bit page table entries (ie, PAE) which requires
>> CONFIG_HIGHMEM64G.
> 
> Somehow there is a problem: a user can explicitly put "noexec=on" and it
> will be silently ignored if the kernel doesn't have PAE support. I guess
> that currently no message is written because "noexec=on" is the
> _default_. Still, it would be fair to the user who added "noexec=on" on
> its command line that if it is not respected, either because the
> hardware doesn't support it or because the kernel doesn't support it, we
> display a warning saying it's hopeless.
> 

Would have saved me and others a lot of trouble if this happened, yes; I
wouldn't have written a test case and wtf'd at it for 5 days.  :)

> I'll send a patch if it seems meaningful to you,

Telling may be better than letting the user think; then again any
knowledgeable user should know based on his config (yes I know, by this
logic I should have known about the HIGHMEM64G thing).

> c u
> Eric
> 
> 
> 
> 

- --
    We will enslave their women, eat their children and rape their
    cattle!
                  -- Bosc, Evil alien overlord from the fifth dimension
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iQIVAwUBRX3VJgs1xW0HCTEFAQLmaRAAj1e55b6if2lLTEbFNtylIn2aikAuPC87
wCqzvmdp/NBxUcIgXESdQeCDPxPuNK6OUCT6dtPTNCMu15wn7bfq3QUsXCR6z4za
lI7nBzIhU1ZH6HaGMm2d2MAuXfOg1I+SFEokOzXwh8db6HXGvH8DjP0mDLtKVxKP
yYjUXd8ZK3RPwU7eHUPN/V9s1v0ekc/1uFIlBBQHmzA0la/D32NcwhuCVsTEA8Ne
iix3QqBTn3p3UnD7LhnqaIKfBQEDTKfRnuWeGsf6L764cbyMaoga/6E6S7E8P2Jw
X+D940tAylrG8uH0CnmCDVzEGEPmozvN8Kk+UmSSwzgiFMQ3RlJaBbYEX9VsvqBZ
uIC77KVRHsKc+/nRYfYnDWoXRapWJTqVJfC+Ouuj1pm3NNptaHjSgpsgtHde6MuJ
ZZvvFhjN1iedDSCzRRYP4OLKTvomdiIQ9XrKPdfkqUvSgJZS7/zvCn+q6mZZDlqc
SthGcf9wCTSplGNwXzeIwMA14DGN6zZabA4ZTHNeyrLMAjzCrzd4/T8DSNGTyT0d
EotN0paFP5p7rgY37o7D+smm7m2V+zfGMn8iQr64E/xUDlySbEJKuea7VANzTj/1
FtLSb4rQRgA0yNaeCFuNQkvaCtn0U0/Ot/E7GQM53Hjr43mq2Pienc6+U/1KHFje
cmZt2/ZbzeM=
=pgCd
-----END PGP SIGNATURE-----

