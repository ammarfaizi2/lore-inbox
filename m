Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317773AbSGPHqY>; Tue, 16 Jul 2002 03:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317777AbSGPHqX>; Tue, 16 Jul 2002 03:46:23 -0400
Received: from sccrmhc02.attbi.com ([204.127.202.62]:52162 "EHLO
	sccrmhc02.attbi.com") by vger.kernel.org with ESMTP
	id <S317773AbSGPHqU>; Tue, 16 Jul 2002 03:46:20 -0400
From: "Buddy Lumpkin" <b.lumpkin@attbi.com>
To: "Nick Bellinger" <nickb@attheoffice.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: IDE/ATAPI in 2.5
Date: Tue, 16 Jul 2002 00:49:46 -0700
Message-ID: <FJEIKLCALBJLPMEOOMECIEGJCOAA.b.lumpkin@attbi.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <1026757651.9529.36.camel@subjeKt>
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.3018.1300
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As apposed to creating a huge list of URL's to illustrate my point, since
EMC LUNS were provided below, i'll point you to EMC's "NAS" solution:

http://www.emc.com/products/networking/celerra.jsp?openfolder=storage_networ
king

They are called "EMC Celerra File Servers" and to keep you from reading the
whole site I'll sum it up here. It's a card that you slide into the
symmetrix to provide Network Attached Storage, AKA NFS front end to storage
that may or may not be also available on a SAN which implies a connection to
a fabric.

Regards,

--Buddy



-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Nick Bellinger
Sent: Monday, July 15, 2002 11:28 AM
To: Buddy Lumpkin
Cc: linux-kernel@vger.kernel.org
Subject: RE: IDE/ATAPI in 2.5




>I think someone is misunderstanding some industry buzz words here ...
>NAS refers to Network Attached Storage, as in via NFS, AFS, et al.
>What your showing in the output of the Solaris format command are
>raw SCSI LUNS attached via fibre channel (fabric or loop) or native
>scsi.

Just as a matter of clarification, the above two examples NFS and AFS
are most certainly NOT Network Attached Storage aka NAS.  The former is
an simple Networked File System, and the latter the first practical
distributed file system (ie: multiple client access to shares), but they
both provide access to storage resources at the FILE SYSTEM level.

The term 'NAS' (and SAN for that matter as the terms are pretty much
used interchangeably these days) refer to moving raw disk protocol
Command Descriptor Blocks aka CDBs and its associated data across the
network at the BLOCK level.  But storage folks generically regard the
terms as: NAS refers to BLOCK level storage over IP networks,  and SAN
to BLOCK level storage over a Fibre Channel setup.

The reason being a Storage Area Network is generally a closed, secure,
and seperate entity from ones IP network,  while Network Attached
Storage is storage added directly into an existing IP network.  Of
course this opens up all of related security considerations when dealing
with IP networks,  but a discussion of the related issues is beyond the
scope of this reply, and dangerously off-topic.


		Nicholas 'trying to keep it real' Bellinger


>>From venom@sns.it Mon Jul 15 11:11:59 2002
>>On Sun, 14 Jul 2002, Rik van Riel wrote:

>>> > BTW: did you ever look at Solaris / HP-UX, ... and the way they
>>> > name disks?
>>> >
>>> > someting like: /dev/{r}dsk/c0t0d0s0
>>> > This is SCSI bus, target, lun and slice.
>>>
>>> I wonder what they'll change it to in order to support
>>> network attached storage.
>>>
>>Actually notthing:

>>dbtecnocasa:{root}:/>format
>>Searching for disks...done

>>c2t1d0: configured with capacity of 6.56MB
>>c2t1d30: configured with capacity of 34.04GB
>>c2t1d31: configured with capacity of 34.04GB
>>c2t1d81: configured with capacity of 34.04GB


>>AVAILABLE DISK SELECTIONS:
>>       0. c0t0d0 <SUN18G cyl 7506 alt 2 hd 19 sec 248>
>>          /pci@1f,4000/scsi@3/sd@0,0
>>       1. c2t1d0 <EMC-SYMMETRIX-5567 cyl 14 alt 2 hd 15 sec 64>
>>          /pci@4,2000/scsi@1/sd@1,0
>>       2. c2t1d30 <EMC-SYMMETRIX-5567 cyl 37178 alt 2 hd 30 sec 64>
>>          /pci@4,2000/scsi@1/sd@1,1e
>>       3. c2t1d31 <EMC-SYMMETRIX-5567 cyl 37178 alt 2 hd 30 sec 64>
>>          /pci@4,2000/scsi@1/sd@1,1f
>>       4. c2t1d81 <EMC-SYMMETRIX-5567 cyl 37178 alt 2 hd 30 sec 64>
>>          /pci@4,2000/scsi@1/sd@1,51

>>except of c0t0d0 everything else is network attached...


>How is it attached? Using FACL or ISCSI?

>In any case, it seems to be a natural solution to do it this way.

>In order to access a network disk, you need to obtain the right to
>do so first. Once this has been done, the netork subsystem just looks
>like a new SCSI bus.

>Jörg



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

