Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751404AbWENV2o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751404AbWENV2o (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 May 2006 17:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751412AbWENV2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 May 2006 17:28:44 -0400
Received: from usea-naimss1.unisys.com ([192.61.61.103]:57351 "EHLO
	usea-naimss1.unisys.com") by vger.kernel.org with ESMTP
	id S1751404AbWENV2n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 May 2006 17:28:43 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C6779D.55F170DE"
Subject: RE: [PATCH 0/10] bulk cpu removal support
Date: Sun, 14 May 2006 16:28:26 -0500
Message-ID: <19D0D50E9B1D0A40A9F0323DBFA04ACC023B0BEF@USRV-EXCH4.na.uis.unisys.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 0/10] bulk cpu removal support
Thread-Index: AcZ1V/ViTjJ/kowOSJCa8g0DxVCvwACPk1FgAAGyRtA=
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       "Nathan Lynch" <ntl@pobox.com>, "Ashok Raj" <ashok.raj@intel.com>
Cc: "Martin Bligh" <mbligh@mbligh.org>, "Andrew Morton" <akpm@osdl.org>,
       <shaohua.li@intel.com>, <linux-kernel@vger.kernel.org>,
       <zwane@linuxpower.ca>, <vatsa@in.ibm.com>, <nickpiggin@yahoo.com.au>
X-OriginalArrivalTime: 14 May 2006 21:28:26.0764 (UTC) FILETIME=[56460CC0:01C6779D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C6779D.55F170DE
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> Per Ashok's request here is some data on offlining with=20
> cpu_bulk_remove vs. sequentially with a shell script.
> I had 64x system (physical CPU) and 128 (those 64=20
> hyperthreaded). The system was idle.=20
> Elapsed times are not strikingly different but system/user times are:
>=20
>                 64 CPU                                       =20
>   128 CPU
> (64 physical hyperthreaded)
>                 cpu_bulk_remove         shell script
> cpu_bulk_remove         shell script
> all offline     real    0m11.231s       real    0m10.775s       real
> 0m26.973s       real    0m16.484s
>                 user    0m0.000s        user    0m0.056         user
> 0m0.000s        user    0m0.068s
>                 sys     0m0.072s        sys     0m0.448         sys
> 0m0.132s        sys     0m1.312s
>=20
>                 real    0m11.977s       real    0m10.550s       real
> 0m28.978s       real    0m14.259s
>                 user    0m0.000s        user    0m0.064s        user
> 0m0.000s        user    0m0.060s
>                 sys     0m0.032s        sys     0m0.464s        sys
> 0m0.152s        sys     0m1.432s
>=20
> 32 offline      real    0m1.320s        real    0m2.422s        real
> 0m1.647s        real    0m1.896s
>                 user    0m0.000s        user    0m0.000s        user
> 0m0.000s        user    0m0.020s
>                 sys     0m0.076s        sys     0m0.232s        sys
> 0m0.096s        sys     0m0.456s
>=20
>                 real    0m1.407s        real    0m3.348s        real
> 0m0.418s        real    0m1.198s
>                 user    0m0.000s        user    0m0.012s        user
> 0m0.000s        user    0m0.008s
>                 sys     0m0.072s        sys     0m0.276s        sys
> 0m0.044s        sys     0m0.244s
>=20
> groups of 16    real 0m5.877s           real 0m11.403s
>                 user 0m0.000s           user 0m0.024s
>                 sys 0m0.140s            sys 0m0.408s
>=20
> groups of 8     real 0m8.847s           real 0m12.078s          real
> 0m12.311s       real    0m12.736s
>                 user 0m0.004s           user 0m0.028s           user
> 0m0.004s        user    0m0.076s
>                 sys 0m0.232s            sys 0m0.536s            sys
> 0m0.448s        sys     0m1.448s
>=20
>                                                                 real
> 0m11.968s       real    0m14.314s
>                                                                 user
> 0m0.008s        user    0m0.084s
>                                                                 sys
> 0m0.400s        sys     0m1.492s
>=20
> With smaller "bulks" cpu_bulk_remove is always better, but=20
> with large ones shell script mostly wins, especially with=20
> hyperthreading (despite of much better system and user times!)
>=20
Oops it all wrapped :O=20
I'm attaching the data file instead, sorry about that.

--Natalie
>=20

------_=_NextPart_001_01C6779D.55F170DE
Content-Type: application/octet-stream;
	name="cpu_data"
Content-Transfer-Encoding: base64
Content-Description: cpu_data
Content-Disposition: attachment;
	filename="cpu_data"

CQk2NCBDUFUJCQkJCQkxMjggQ1BVICg2NCBwaHlzaWNhbCBoeXBlcnRocmVhZGVkKQkJCgkJY3B1
X2J1bGtfcmVtb3ZlCQlzaGVsbCBzY3JpcHQJCWNwdV9idWxrX3JlbW92ZQkJc2hlbGwgc2NyaXB0
CmFsbCBvZmZsaW5lCXJlYWwgICAgMG0xMS4yMzFzCXJlYWwgICAgMG0xMC43NzVzCXJlYWwgICAg
MG0yNi45NzNzCXJlYWwgICAgMG0xNi40ODRzCgkJdXNlciAgICAwbTAuMDAwcwl1c2VyICAgIDBt
MC4wNTYJCXVzZXIgICAgMG0wLjAwMHMJdXNlciAgICAwbTAuMDY4cwoJCXN5cyAgICAgMG0wLjA3
MnMJc3lzICAgICAwbTAuNDQ4CQlzeXMgICAgIDBtMC4xMzJzCXN5cyAgICAgMG0xLjMxMnMKCQkJ
CQoJCXJlYWwgICAgMG0xMS45NzdzCXJlYWwgICAgMG0xMC41NTBzCXJlYWwgICAgMG0yOC45Nzhz
CXJlYWwgICAgMG0xNC4yNTlzCgkJdXNlciAgICAwbTAuMDAwcwl1c2VyICAgIDBtMC4wNjRzCXVz
ZXIgICAgMG0wLjAwMHMJdXNlciAgICAwbTAuMDYwcwoJCXN5cyAgICAgMG0wLjAzMnMJc3lzICAg
ICAwbTAuNDY0cwlzeXMgICAgIDBtMC4xNTJzCXN5cyAgICAgMG0xLjQzMnMKCQkJCjMyIG9mZmxp
bmUJcmVhbCAgICAwbTEuMzIwcwlyZWFsICAgIDBtMi40MjJzCXJlYWwgICAgMG0xLjY0N3MJcmVh
bCAgICAwbTEuODk2cwoJCXVzZXIgICAgMG0wLjAwMHMJdXNlciAgICAwbTAuMDAwcwl1c2VyICAg
IDBtMC4wMDBzCXVzZXIgICAgMG0wLjAyMHMKCQlzeXMgICAgIDBtMC4wNzZzCXN5cyAgICAgMG0w
LjIzMnMJc3lzICAgICAwbTAuMDk2cwlzeXMgICAgIDBtMC40NTZzCgkJCQkJCQoJCXJlYWwgICAg
MG0xLjQwN3MJcmVhbCAgICAwbTMuMzQ4cwlyZWFsICAgIDBtMC40MThzCXJlYWwgICAgMG0xLjE5
OHMKCQl1c2VyICAgIDBtMC4wMDBzCXVzZXIgICAgMG0wLjAxMnMJdXNlciAgICAwbTAuMDAwcwl1
c2VyICAgIDBtMC4wMDhzCgkJc3lzICAgICAwbTAuMDcycwlzeXMgICAgIDBtMC4yNzZzCXN5cyAg
ICAgMG0wLjA0NHMJc3lzICAgICAwbTAuMjQ0cwkKCmdyb3VwcyBvZiAxNglyZWFsIDBtNS44Nzdz
CQlyZWFsIDBtMTEuNDAzcwkJCQkJCgkJdXNlciAwbTAuMDAwcwkJdXNlciAwbTAuMDI0cwkJCQkJ
CgkJc3lzIDBtMC4xNDBzCQlzeXMgMG0wLjQwOHMJCQkJCQoJCQkJCQkJCmdyb3VwcyBvZiA4CXJl
YWwgMG04Ljg0N3MJCXJlYWwgMG0xMi4wNzhzCQlyZWFsICAgIDBtMTIuMzExcwlyZWFsICAgIDBt
MTIuNzM2cwkKCQl1c2VyIDBtMC4wMDRzCQl1c2VyIDBtMC4wMjhzCQl1c2VyICAgIDBtMC4wMDRz
CXVzZXIgICAgMG0wLjA3NnMJCgkJc3lzIDBtMC4yMzJzCQlzeXMgMG0wLjUzNnMJCXN5cyAgICAg
MG0wLjQ0OHMJc3lzICAgICAwbTEuNDQ4cwkKCQkJCQkJCgkJCQkJCQkJcmVhbCAgICAwbTExLjk2
OHMJcmVhbCAgICAwbTE0LjMxNHMJCgkJCQkJCQkJdXNlciAgICAwbTAuMDA4cwl1c2VyICAgIDBt
MC4wODRzCQoJCQkJCQkJCXN5cyAgICAgMG0wLjQwMHMJc3lzICAgICAwbTEuNDkycwkKCg==

------_=_NextPart_001_01C6779D.55F170DE--
