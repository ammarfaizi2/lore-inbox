Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbRBMU6Y>; Tue, 13 Feb 2001 15:58:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129215AbRBMU6P>; Tue, 13 Feb 2001 15:58:15 -0500
Received: from limes.hometree.net ([194.231.17.49]:16198 "EHLO
	limes.hometree.net") by vger.kernel.org with ESMTP
	id <S129183AbRBMU6C>; Tue, 13 Feb 2001 15:58:02 -0500
To: linux-kernel@vger.kernel.org
Date: Tue, 13 Feb 2001 20:39:52 +0000 (UTC)
From: "Henning P. Schmiedehausen" <hps@tanstaafl.de>
Message-ID: <96c62o$o69$1@forge.intermeta.de>
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
In-Reply-To: <968mjv$l9t$1@forge.intermeta.de>, <7vh2HM81w-B@khms.westfalen.de>
Reply-To: hps@tanstaafl.de
Subject: Re: DNS goofups galore...
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kaih@khms.westfalen.de (Kai Henningsen) writes:

>hps@tanstaafl.de (Henning P. Schmiedehausen)  wrote on 12.02.01 in <968mjv$l9t$1@forge.intermeta.de>:

>> jan.gyselinck@be.uu.net (Jan Gyselinck) writes:
>>
>> >There's not really something wrong with MX's pointing to CNAME's.  It's
>> >just that some mailservers could (can?) not handle this.  So if you want to
>> >be able to receive mail from all kinds of mailservers, don't use CNAME's
>> >for MX's.
>>
>> No. It breaks a basic assumption set in stone in RFC821. It has
>> nothing to do with mailer software.

>May I point out that RFC 821 does not mention either CNAME or MX anywhere.

RFC 974 is about the "DOMAIN NAME SYSTEM". RFC 821 mentions DOMAINS:

3.7.  DOMAINS

>So don't tell us about stuff set in stone in RFC XYZ, when it's plain  
>you've never looked at that RFC.

Says who? RFC974 is a clarification of how to interpret Domain Name
System contents in a mail context. RFC821 makes a clear statement about
Domains in section 3.7:

[...]
      Whenever domain names are used in SMTP only the official names are
      used, the use of nicknames or aliases is not allowed.
[...]

and in RFC974 it is stated:

[...]
   In addition to mail information, the servers store certain other
   types of RR's which mailers may encounter or choose to use.  These
   are: the canonical name (CNAME) RR, which simply states that the
   domain name queried for is actually an alias for another domain name,
   which is the proper, or canonical, name; [...]
[...]

In my understanding (and I assume that you're familiar with both as
you've chosen to insult me by suggesting that I've not read this
stuff), this means clearly:

"YOU MUST NOT USE AN ALIAS WHENEVER DOMAINS ARE USED IN SMTP". (RFC821)

and

"THIS NAME IS AN ALIAS FOR ANOTHER DOMAIN NAME, WHICH IS THE PROPER,
CANONICAL NAME".

This boils down for me to 

"YOU MUST NOT USE A CNAME ANYWHERE IN SMTP".

and "ANYWHERE" also states for me "in the 220 greeting".

Any further questions?

	Regards
		Henning
-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
