Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <157350-26601>; Wed, 21 Oct 1998 08:22:29 -0400
Received: from hera.cwi.nl ([192.16.191.1]:64053 "EHLO hera.cwi.nl" ident: "SOCKWRITE-65") by vger.rutgers.edu with ESMTP id <157505-26601>; Wed, 21 Oct 1998 07:00:38 -0400
Date: Wed, 21 Oct 1998 19:39:41 +0200 (MET DST)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC199810211739.TAA34047.aeb@texel.cwi.nl>
To: kaos@ocs.com.au
Subject: Re: New ksymoops that handles modules (was Re: How to translate an oops)
Cc: linux-kernel@vger.rutgers.edu
Sender: owner-linux-kernel@vger.rutgers.edu

> Ask and ye shall receive :).

Very good! This is what I had hoped for.
However, still some improvements are possible.
I just tried an Oops, and get

----------------------------------------------------------
# ./ksymoops -VOKM < /or/usr/log/oops
Options used: -V -O -K -M

Warning, no symbols in merged map
Warning, Code line not seen, dumping what data is available

Trace: 11127c No symbols available
Trace: 10a254 No symbols available
Trace: 10aae5 No symbols available


2 warnings issued.  Results may not be reliable.
----------------------------------------------------------

while Alessandro gives

----------------------------------------------------------
EIP:    0030:0011127c 
EFLAGS: 00000246
eax: 0000000d 
ebx: 00ef2018 
ecx: 0000000d 
edx: 001fd434 
esi: 011da830 
edi: 011da830 
ebp: 00efbfa8 <%esp+28>
esp: 00efbf80 <%esp+0>
ds: 0018   es: 0038   fs: 002b   gs: 002b   ss: 0018
Process runslip (pid: 48, process nr: 18, stackpage=00efb000)
esp+00: 00002000 
esp+04: 00efbfbc <%esp+3c>
...
Trace: 001e002b 
Trace: 02800000 
Trace: 03000000 
Trace: 02800000 
Trace: 0010b3bd 
Trace: 0010b380 
Trace: 0010ac70 
Trace: 0011127c 
Trace: 0010a254 
Trace: 0010aae5 
Code: 0010b069:
----------------------------------------------------------

and the kernel source ksymoops.cc

----------------------------------------------------------
No symbol map.  I'll only show you disassembled code.
----------------------------------------------------------

So at present, for this one particular Oops, Alessandro
still is the winner.

Andries


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
