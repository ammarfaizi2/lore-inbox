Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263942AbUDNH3D (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 03:29:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263947AbUDNH3D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 03:29:03 -0400
Received: from fmr05.intel.com ([134.134.136.6]:47519 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S263942AbUDNH2w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 03:28:52 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C421F2.1227B672"
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: Non-Exec stack patches
Date: Wed, 14 Apr 2004 00:28:24 -0700
Message-ID: <9AB83E4717F13F419BD880F5254709E5011EBABA@scsmsx402.sc.intel.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: Non-Exec stack patches
Thread-Index: AcQROUKTnnY+O6NiSLqQYsLhNbrRTgQttgpQ
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: "Andrew Morton" <akpm@osdl.org>, "Kurt Garloff" <garloff@suse.de>
Cc: <linux-kernel@vger.kernel.org>, <mingo@redhat.com>
X-OriginalArrivalTime: 14 Apr 2004 07:28:25.0159 (UTC) FILETIME=[12A17570:01C421F2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C421F2.1227B672
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Andrew Morton
> Sent: Tuesday, March 23, 2004 4:41 PM
> To: Kurt Garloff
> Cc: linux-kernel@vger.kernel.org; mingo@redhat.com
> Subject: Re: Non-Exec stack patches
>=20
>=20
> Kurt Garloff <garloff@suse.de> wrote:
> >
> > > Which architectures are currently making their pre-page=20
> execute permissions
> > > depend upon VM_EXEC?  Would additional arch patches be=20
> needed for this?
> >=20
> > It works on AMD64 (not ia32e), both for 64bit and 32bit binaries.
> > I have not yet tested other archs.
> >=20
> > If the values in the protection_map are different depending=20
> on bit 2,
> > the patch will be effecitve. (OK, the CPU/MMU needs to honour the
> > setting of course.) Most likely, the values for=20
> > protection_map[7] is PAGE_COPY_EXEC and of protection_map[3] is
> > PAGE_COPY.
>=20
> OK.
>=20

Recent ia64 mm trees are broken because of this issue. Attached patch =
fixes protection_map[7] in IA64.

thanks,
suresh

------_=_NextPart_001_01C421F2.1227B672
Content-Type: application/octet-stream;
	name="noexec-ia64.fix"
Content-Transfer-Encoding: base64
Content-Description: noexec-ia64.fix
Content-Disposition: attachment;
	filename="noexec-ia64.fix"

LS0tIGxpbnV4LTI2NW1tNS9pbmNsdWRlL2FzbS1pYTY0L3BndGFibGUuaH4JMjAwNC0wNC0xNCAw
MDowOTowNC4wMDAwMDAwMDAgLTA3MDAKKysrIGxpbnV4LTI2NW1tNS9pbmNsdWRlL2FzbS1pYTY0
L3BndGFibGUuaAkyMDA0LTA0LTEzIDIzOjQ1OjI5LjAwMDAwMDAwMCAtMDcwMApAQCAtMTQ4LDcg
KzE0OCw3IEBACiAjZGVmaW5lIF9fUDEwMAlfX3BncHJvdChfX0FDQ0VTU19CSVRTIHwgX1BBR0Vf
UExfMyB8IF9QQUdFX0FSX1hfUlgpCiAjZGVmaW5lIF9fUDEwMQlfX3BncHJvdChfX0FDQ0VTU19C
SVRTIHwgX1BBR0VfUExfMyB8IF9QQUdFX0FSX1JYKQogI2RlZmluZSBfX1AxMTAJUEFHRV9DT1BZ
Ci0jZGVmaW5lIF9fUDExMQlQQUdFX0NPUFkKKyNkZWZpbmUgX19QMTExCVBBR0VfQ09QWV9FWEVD
CiAKICNkZWZpbmUgX19TMDAwCVBBR0VfTk9ORQogI2RlZmluZSBfX1MwMDEJUEFHRV9SRUFET05M
WQo=

------_=_NextPart_001_01C421F2.1227B672--
