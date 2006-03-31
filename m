Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932128AbWCaV2k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128AbWCaV2k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 16:28:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751414AbWCaV2k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 16:28:40 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:24545 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751412AbWCaV2j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 16:28:39 -0500
Date: Fri, 31 Mar 2006 13:28:13 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: davem@davemloft.net
cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       "'Nick Piggin'" <nickpiggin@yahoo.com.au>,
       Zoltan Menyhart <Zoltan.Menyhart@bull.net>,
       "Boehm, Hans" <hans.boehm@hp.com>,
       "Grundler, Grant G" <grant.grundler@hp.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: RE: Synchronizing Bit operations V2
In-Reply-To: <200603312123.k2VLNqg06655@unix-os.sc.intel.com>
Message-ID: <Pine.LNX.4.64.0603311327050.8126@schroedinger.engr.sgi.com>
References: <200603312123.k2VLNqg06655@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1700579579-988016669-1143840493=:8126"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1700579579-988016669-1143840493=:8126
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 31 Mar 2006, Chen, Kenneth W wrote:

> > I think we could say that lock semantics are different from barriers. T=
hey=20
> > are more like acquire and release on IA64. The problem with smb_mb_*** =
is=20
> > that the coder *explicitly* requested a barrier operation and we do not=
=20
> > give it to him.
>=20
> I was browsing sparc64 code and it defines:
>=20
> include/asm-sparc64/bitops.h:
> #define smp_mb__after_clear_bit()      membar_storeload_storestore()
>=20
> With my very na=EFve knowledge of sparc64, it doesn't look like a full ba=
rrier.
> Maybe sparc64 is broken too ...

Dave, how does sparc64 handle this situation?

---1700579579-988016669-1143840493=:8126--
