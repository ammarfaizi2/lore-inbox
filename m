Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317439AbSGOLTo>; Mon, 15 Jul 2002 07:19:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317436AbSGOLTo>; Mon, 15 Jul 2002 07:19:44 -0400
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:27579 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S317437AbSGOLTl>; Mon, 15 Jul 2002 07:19:41 -0400
From: "Buddy Lumpkin" <b.lumpkin@attbi.com>
To: <linux-kernel@vger.kernel.org>
Cc: <Richard.Zidlicky@stud.informatik.uni-erlangen.de>,
       <andersen@codepoet.org>, "Joerg Schilling" <schilling@fokus.gmd.de>,
       <riel@conectiva.com.br>, <venom@sns.it>
Subject: RE: IDE/ATAPI in 2.5
Date: Mon, 15 Jul 2002 04:23:03 -0700
Message-ID: <FJEIKLCALBJLPMEOOMECMEELCOAA.b.lumpkin@attbi.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <200207150920.g6F9Kj7v019998@burner.fokus.gmd.de>
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.3018.1300
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think someone is misunderstanding some industry buzz words here ...
NAS refers to Network Attached Storage, as in via NFS, AFS, et al.
What your showing in the output of the Solaris format command are
raw SCSI LUNS attached via fibre channel (fabric or loop) or native scsi.

--Buddy

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Joerg Schilling
Sent: Monday, July 15, 2002 2:21 AM
To: riel@conectiva.com.br; venom@sns.it
Cc: Richard.Zidlicky@stud.informatik.uni-erlangen.de;
andersen@codepoet.org; linux-kernel@vger.kernel.org;
schilling@fokus.gmd.de
Subject: Re: IDE/ATAPI in 2.5


>From venom@sns.it Mon Jul 15 11:11:59 2002
>On Sun, 14 Jul 2002, Rik van Riel wrote:

>> > BTW: did you ever look at Solaris / HP-UX, ... and the way they
>> > name disks?
>> >
>> > someting like: /dev/{r}dsk/c0t0d0s0
>> > This is SCSI bus, target, lun and slice.
>>
>> I wonder what they'll change it to in order to support
>> network attached storage.
>>
>Actually notthing:

>dbtecnocasa:{root}:/>format
>Searching for disks...done

>c2t1d0: configured with capacity of 6.56MB
>c2t1d30: configured with capacity of 34.04GB
>c2t1d31: configured with capacity of 34.04GB
>c2t1d81: configured with capacity of 34.04GB


>AVAILABLE DISK SELECTIONS:
>       0. c0t0d0 <SUN18G cyl 7506 alt 2 hd 19 sec 248>
>          /pci@1f,4000/scsi@3/sd@0,0
>       1. c2t1d0 <EMC-SYMMETRIX-5567 cyl 14 alt 2 hd 15 sec 64>
>          /pci@4,2000/scsi@1/sd@1,0
>       2. c2t1d30 <EMC-SYMMETRIX-5567 cyl 37178 alt 2 hd 30 sec 64>
>          /pci@4,2000/scsi@1/sd@1,1e
>       3. c2t1d31 <EMC-SYMMETRIX-5567 cyl 37178 alt 2 hd 30 sec 64>
>          /pci@4,2000/scsi@1/sd@1,1f
>       4. c2t1d81 <EMC-SYMMETRIX-5567 cyl 37178 alt 2 hd 30 sec 64>
>          /pci@4,2000/scsi@1/sd@1,51

>except of c0t0d0 everything else is network attached...


How is it attached? Using FACL or ISCSI?

In any case, it seems to be a natural solution to do it this way.

In order to access a network disk, you need to obtain the right to
do so first. Once this has been done, the netork subsystem just looks
like a new SCSI bus.

Jörg

 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353
Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.gmd.de		(work) chars I am J"org Schilling
 URL:  http://www.fokus.gmd.de/usr/schilling
ftp://ftp.fokus.gmd.de/pub/unix
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

