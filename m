Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268417AbTAMXMm>; Mon, 13 Jan 2003 18:12:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268420AbTAMXMm>; Mon, 13 Jan 2003 18:12:42 -0500
Received: from fmr02.intel.com ([192.55.52.25]:56316 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S268417AbTAMXMk>; Mon, 13 Jan 2003 18:12:40 -0500
content-class: urn:content-classes:message
Subject: [PATCH][2.5] APIC version
Date: Mon, 13 Jan 2003 13:15:28 -0800
Message-ID: <C8C38546F90ABF408A5961FC01FDBF1912E21A@fmsmsx405.fm.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C2BB48.E5C41FD6"
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH][2.5] APIC version
X-MimeOLE: Produced By Microsoft Exchange V6.0.6334.0
Thread-Index: AcK7QZCdyMgUZyczEdetAABQi+Bv6wABkckA
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Protasevich, Natalie" <Natalie.Protasevich@Unisys.Com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>
Cc: "William Lee Irwin III" <wli@holomorphy.com>,
       "Christoph Hellwig" <hch@infradead.org>,
       "James Cleverdon" <jamesclv@us.ibm.com>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 13 Jan 2003 21:15:29.0207 (UTC) FILETIME=[E6168470:01C2BB48]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C2BB48.E5C41FD6
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


Attached is the one-line patch, to get proper APIC version while
initializing through ACPI.

Thanks,
-Venkatesh

> -----Original Message-----
> From: Protasevich, Natalie [mailto:Natalie.Protasevich@UNISYS.com]=20
> Sent: Monday, January 13, 2003 12:22 PM
> To: Nakajima, Jun; Protasevich, Natalie; Martin J. Bligh;=20
> Pallipadi, Venkatesh
> Cc: William Lee Irwin III; Christoph Hellwig; James=20
> Cleverdon; Linux Kernel
> Subject: RE: APIC version
>=20
>=20
> Wow, this is pretty brilliant, Jun! In cases like this one=20
> always thinks
> "Why this didn't occur to me, this is so obvious..."=20
> (Sadly I noticed that I tend to go "round and about"=20
> sometimes instead of
> direct :(
> I hope this will get incorporated in the source tree.
>=20
> Thanks,
>=20
> --Natalie=20
>=20
>=20
> -----Original Message-----
> From: Nakajima, Jun [mailto:jun.nakajima@intel.com]
> Sent: Monday, January 13, 2003 1:13 PM
> To: Protasevich, Natalie; Martin J. Bligh; Pallipadi, Venkatesh
> Cc: William Lee Irwin III; Christoph Hellwig; James Cleverdon; Linux
> Kernel
> Subject: RE: APIC version
>=20
>=20
> The only thing you need to do is=20
> 	processor.mpc_type =3D MP_PROCESSOR;
>  	processor.mpc_apicid =3D id;
> -	processor.mpc_apicver =3D 0x10; /* TBD: lapic version */
> +	processor.mpc_apicver =3D GET_APIC_VERSION(apic_read(APIC_LVR));
>  	processor.mpc_cpuflag =3D (enabled ? CPU_ENABLED : 0);
>  	processor.mpc_cpuflag |=3D (boot_cpu ? CPU_BOOTPROCESSOR : 0);
>  	processor.mpc_cpufeature =3D (boot_cpu_data.x86 << 8) |
>=20
> Jun
>=20
> >
>=20

------_=_NextPart_001_01C2BB48.E5C41FD6
Content-Type: application/octet-stream;
	name="apic_ver.patch"
Content-Transfer-Encoding: base64
Content-Description: apic_ver.patch
Content-Disposition: attachment;
	filename="apic_ver.patch"

LS0tIGxpbnV4LTIuNS41NS9hcmNoL2kzODYva2VybmVsL21wcGFyc2UuYy5vcmcJMjAwMy0wMS0x
MyAxNDowMjoxOS4wMDAwMDAwMDAgLTA4MDAKKysrIGxpbnV4LTIuNS41NS9hcmNoL2kzODYva2Vy
bmVsL21wcGFyc2UuYwkyMDAzLTAxLTEzIDE0OjAzOjEzLjAwMDAwMDAwMCAtMDgwMApAQCAtNzk1
LDcgKzc5NSw3IEBACiAKIAlwcm9jZXNzb3IubXBjX3R5cGUgPSBNUF9QUk9DRVNTT1I7CiAJcHJv
Y2Vzc29yLm1wY19hcGljaWQgPSBpZDsKLQlwcm9jZXNzb3IubXBjX2FwaWN2ZXIgPSAweDEwOyAv
KiBUQkQ6IGxhcGljIHZlcnNpb24gKi8KKwlwcm9jZXNzb3IubXBjX2FwaWN2ZXIgPSBHRVRfQVBJ
Q19WRVJTSU9OKGFwaWNfcmVhZChBUElDX0xWUikpOwogCXByb2Nlc3Nvci5tcGNfY3B1ZmxhZyA9
IChlbmFibGVkID8gQ1BVX0VOQUJMRUQgOiAwKTsKIAlwcm9jZXNzb3IubXBjX2NwdWZsYWcgfD0g
KGJvb3RfY3B1ID8gQ1BVX0JPT1RQUk9DRVNTT1IgOiAwKTsKIAlwcm9jZXNzb3IubXBjX2NwdWZl
YXR1cmUgPSAoYm9vdF9jcHVfZGF0YS54ODYgPDwgOCkgfCAK

------_=_NextPart_001_01C2BB48.E5C41FD6--
