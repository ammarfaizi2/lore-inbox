Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262387AbSKHVAT>; Fri, 8 Nov 2002 16:00:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262391AbSKHVAT>; Fri, 8 Nov 2002 16:00:19 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:11022 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S262387AbSKHVAS>; Fri, 8 Nov 2002 16:00:18 -0500
Date: Fri, 8 Nov 2002 16:05:53 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
cc: linux-kernel@vger.kernel.org, mbligh@aracnet.com, jw@pegasys.ws,
       wa@almesberger.net, andersen@codepoet.org, woofwoof@hathway.com
Subject: Re: ps performance sucks
In-Reply-To: <200211072042.gA7KglX121245@saturn.cs.uml.edu>
Message-ID: <Pine.LNX.3.96.1021108153904.4445A-200000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1170656797-2036164466-1036789553=:4445"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1170656797-2036164466-1036789553=:4445
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Thu, 7 Nov 2002, Albert D. Cahalan wrote:

> Are you a vmstat user? Suggestions are needed; it's getting a rewrite.
> I may even change the default format, assuming people don't all
> have scripts that parse the output. How do you like this?
> 
> procs ------------memory----------- ---swap-- ----io--- --system-- ----cpu----
>  r  b swpd free buff cache act !act   si   so   bi   bo   in    cs us sy id wa
>  0  0 304k  14m 2.5m  27m  16m  23m    0    0    0    0   33     4  0  0 90  9
>  0  0 304k  14m 2.5m  27m  16m  23m    0    0    0    0  114    12  1  0 88 11
>  0  0 304k  14m 2.5m  27m  16m  23m    0    0    0    0  104     6  0  1 91  8

The reason I maintain vmstat2 (NOT based on any of your code AFAIK) is
that I want to see data rates on the non-loopback NICs. I also have a
timestamp every line option and after 2.5 settles a bit and I get the time
to find where things are I want optional stats by individual NIC, and
individual drive and partition if I can find it. It isn't in partitions
any more, and the file I was told to use doesn't exist. Maybe in devicefs?
Oh, and -M starts the output with memory sizes, for a package to generate
usage graphs with a line at physical memory size.

An option to flush the buffers after each line even when writing to a
pipe.

Line length: the w option in ps doesn't worry about it, why should vmstat?
If the user tells you to show more, do it.

vmstat2 output attached (it's wide).

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

--1170656797-2036164466-1036789553=:4445
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="x.tmp"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.3.96.1021108160553.4445B@gatekeeper.tmr.com>
Content-Description: 

U2NyaXB0IHN0YXJ0ZWQgb24gRnJpIE5vdiAgOCAxNTo0OTo1NiAyMDAyDQpu
ZXdzY29uMDI6ZWFydGhxdWFrZSQgdm1zdGF0MiAtdGtmTSAxMCA1DQpNZW1U
b3RhbDogICAgICAxNTUxODQwIGtCDQpTd2FwVG90YWw6ICAgICAyMDQ4MjQ4
IGtCDQp0aW1lICAgbG9hZCBmcmVlIGJ1ZmZzIHN3YXAgcGdpbiBwZ291IGRr
MCBkazEgZGsyIGRrMyBpcGt0IG9wa3QgIGludCAgY3R4ICAgdXNyIHN5cyBp
ZGwgIGlfbmV0SyAgb19uZXRLDQoxNS44MzkgOC4yNSAgNS4xICAxNDEyIDQ5
LjAgMzg2MSA4NTg4ICAxMCAyNDMgICAwICAgMCA2MDkyIDYyNjQgODIxNiAz
NDA4ICAgIDM1ICAzNyAgMjggIDU3MjIuMiAgNTc4NS4xDQoxNS44NDIgOS4y
NiAgNy4yICAxNDA5IDQ5LjAgNDI3MiAzNzY0ICAxMSAxNzEgICAwICAgMCA3
NzA3IDgxMjQgOTc3MiAzNTg1ICAgIDQzICA0MyAgMTQgIDczNjkuNiAgNzc0
OC42DQoxNS44NDQgOC4yMSAgNS41ICAxNDEyIDQ5LjAgMzk0MiA3Njg4ICAx
MSAyMzIgICAwICAgMCA2MzUxIDYyODEgODU1NCAzMjg5ICAgIDMwICA0MiAg
MjggIDY0MTIuNyAgNTYxOC45DQoxNS44NDcgNy43NyAgNi43ICAxNDEwIDQ5
LjAgNDkzMiA1MDI5ICAxNSAyMDIgICAwICAgMCA3ODEzIDc4ODYgMTAwNzIg
MzQ2OSAgICA0MiAgNDQgIDE0ICA3NjM5LjkgIDczNDIuMA0KMTUuODUwIDcu
OTkgIDcuMCAgMTQxMCA0OS4wIDQzNjcgNTk3NiAgIDcgMjExICAgMCAgIDAg
NjkwNyA2OTUzIDkwNDUgMzQ2NyAgICAzNyAgMzggIDI1ICA2NzIxLjUgIDY0
NTYuNA0KbmV3c2NvbjAyOmVhcnRocXVha2UkIGV4aXQNCg0KU2NyaXB0IGRv
bmUgb24gRnJpIE5vdiAgOCAxNTo1NjowOCAyMDAyDQo=
--1170656797-2036164466-1036789553=:4445--
