Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317751AbSIEQBL>; Thu, 5 Sep 2002 12:01:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317767AbSIEQBK>; Thu, 5 Sep 2002 12:01:10 -0400
Received: from mta.sara.nl ([145.100.16.144]:14985 "EHLO mta.sara.nl")
	by vger.kernel.org with ESMTP id <S317751AbSIEQBI>;
	Thu, 5 Sep 2002 12:01:08 -0400
Date: Thu, 5 Sep 2002 18:05:32 +0200
Subject: Re: ARP and alias IPs
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v482)
From: Remco Post <r.post@sara.nl>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
In-Reply-To: <20020905153436.GG16092@riesen-pc.gr05.synopsys.com>
Message-Id: <4DE63E30-C0E9-11D6-8864-000393911DE2@sara.nl>
X-Pgp-Agent: GPGMail 0.5.3 (v20)
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


On donderdag, september 5, 2002, at 05:34 , Alex Riesen wrote:

> On Thu, Sep 05, 2002 at 10:09:50AM -0500, Andrew Ryan wrote:
>> The linux implementation of ARP is causing me problems.  Linux sends 
>> out an
>> ARP request with the default interface as the sender address, rather 
>> than then
>> interface the request came on.
>
> http://www.rfc-editor.org/rfc/std/std37.txt
>
>> For example
>>
>> eth0   10.1.1.100
>> eth0:1 192.16.1.101
>
> Are you really expect an aliased interface to work the way you 
> described?


if I read this version of the internet standard correctly, it should 
respond with the ip address that was requested:

"It then notices that it is a request, so it swaps fields, putting
EA(Y) in the new sender Ethernet address field (ar$sha), sets the
opcode to reply, and sends the packet directly (not broadcast) to
EA(X)."

Meaning that the reply must come from the ip-address that was beeing 
looked for in the first place, not just any address used on that 
interface. Though at the time of writing this was not something that was 
in use at all I guess.

So yes, I think it is reasonable to assume that if I do an arp request 
for one address, I do not get a reply for another address that happens 
to be on the same interface... There is no way of determining that this 
is indeed the address I was looking for in the first place. I have not 
checked to see if Linux does this, but if it does it is plain wrong...
- ---
Met vriendelijke groeten,

Remco Post

SARA - Stichting Academisch Rekencentrum Amsterdam    http://www.sara.nl
High Performance Computing  Tel. +31 20 592 8008    Fax. +31 20 668 3167
PGP keys at http://home.sara.nl/~remco/keys.asc

"I really didn't foresee the Internet. But then, neither did the computer
industry. Not that that tells us very much of course - the computer 
industry
didn't even foresee that the century was going to end." -- Douglas Adams


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (Darwin)

iD8DBQE9d4DTBIoCv9yTlOwRAm1zAJ9DyuMA3RlAFYZeJkulWYOFPPrFZwCdGIHx
pIvaA6utByxRaHKq58JdTso=
=jsvP
-----END PGP SIGNATURE-----

