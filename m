Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264268AbUDUIZL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264268AbUDUIZL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 04:25:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264286AbUDUIZL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 04:25:11 -0400
Received: from sigma.informatik.hu-berlin.de ([141.20.20.51]:49327 "EHLO
	sigma.informatik.hu-berlin.de") by vger.kernel.org with ESMTP
	id S264268AbUDUIZH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 04:25:07 -0400
From: Axel =?iso-8859-1?q?Wei=DF?= <aweiss@informatik.hu-berlin.de>
Organization: =?iso-8859-1?q?Humboldt-Universit=E4t=20zu?= Berlin
To: linux-kernel@vger.kernel.org
Subject: Re: linux-2.4.26 released
Date: Wed, 21 Apr 2004 10:25:05 +0200
User-Agent: KMail/1.5.1
References: <200404141314.i3EDEbxv023592@hera.kernel.org> <20040420232312.GQ743@holomorphy.com> <20040421045344.GJ596@alpha.home.local>
In-Reply-To: <20040421045344.GJ596@alpha.home.local>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200404211025.05319.aweiss@informatik.hu-berlin.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 21. April 2004 06:53 schrieb Willy Tarreau:
> Hi William,
>
> On Tue, Apr 20, 2004 at 04:23:12PM -0700, William Lee Irwin III wrote:
> > -		return (mps_cpu/4)*16 + (1<<(mps_cpu%4));
> > +		return (mps_cpu & ~0x3) << 2 | 1 << (mps_cpu & 0x3);
>
>                                         ^^^^
> I think you wanted to put '<< 4' here instead of '<< 2'.

No, the above is correct (at least equivalent):
	(x / 4) * 16 =
	(x >> 2) << 4 =
	(x & ~3) << 2

Regards,
Axel

-- 
Humboldt-Universität zu Berlin
Institut für Informatik
Signalverarbeitung und Mustererkennung
Dipl.-Inf. Axel Weiß
Rudower Chaussee 25
12489 Berlin-Adlershof
+49-30-2093-3050

