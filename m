Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261384AbTJHLmc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 07:42:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261397AbTJHLmc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 07:42:32 -0400
Received: from fmr05.intel.com ([134.134.136.6]:13207 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S261384AbTJHLma convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 07:42:30 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [PATCH] incorrect use of sizeof() in ioctl definitions
Date: Wed, 8 Oct 2003 19:42:23 +0800
Message-ID: <571ACEFD467F7749BC50E0A98C17CDD8F3283D@pdsmsx403.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] incorrect use of sizeof() in ioctl definitions
Thread-Index: AcONgzrJ0ZPU8JAAShG3pJVHzvQ0YwACn43w
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Maciej Zenczykowski" <maze@cela.pl>
Cc: "Andries Brouwer" <aebr@win.tue.nl>, "Andrew Morton" <akpm@osdl.org>,
       "Sharma, Arun" <arun.sharma@intel.com>, <linux-kernel@vger.kernel.org>,
       "Matthew Wilcox" <willy@debian.org>
X-OriginalArrivalTime: 08 Oct 2003 11:42:24.0076 (UTC) FILETIME=[3DA8E8C0:01C38D91]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Wrote from Maciej Zenczykowski [mailto:maze@cela.pl]
> 
> So as not to break userspace we must still support old values, at the
same
> time we want new programs to start using the new correct values -
hence
> the introduction of _backward compatibility_ values.

Thanks. :) Now I see... but are there any rules to decide which part
should be upgraded even breaking the backward compatibility? You know,
the latest 2.6 kernel will request many modules recompiled to run on it.
IMO, most ioctls defined in this bad manner seems to be not-widely used
ones, and... maybe it's worthy of some sacrifice on temporary
compatibility, thus to keep a clean and consistent environment. 

> the old was bad since it was sizeof(sizeof(...)) - it so happens that
by
> def sizeof(anything) is a size_t - thus replacing sizeof(sizeof(..))
with
> sizeof(size_t) changes nothing - just shortens the code...
> Of course what we probably should really have is the above (now) code
> defined as "BAD" and the previous (old) define without the sizeof as
the
> current (no BAD prefix).

Reasonable!

> Yap, both violate.  It is a mess and there is no easy fix due to the
need
> to retain the old invalid ioctl's as well... 

If without such need... :(

Thanks,
Kevin

