Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317742AbSFSOFL>; Wed, 19 Jun 2002 10:05:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317884AbSFSOFK>; Wed, 19 Jun 2002 10:05:10 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:2183 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S317742AbSFSOFJ>; Wed, 19 Jun 2002 10:05:09 -0400
Date: Wed, 19 Jun 2002 15:58:44 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Mikael Pettersson <mikpe@csd.uu.se>
cc: johnstul@us.ibm.com, kai@tp1.ruhr-uni-bochum.de, Martin.Bligh@us.ibm.com,
       davej@suse.de, linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: Re: [Patch] tsc-disable_A5
In-Reply-To: <200206151413.QAA07923@harpo.it.uu.se>
Message-ID: <Pine.GSO.3.96.1020619145508.15094H-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Jun 2002, Mikael Pettersson wrote:

> I disagree with Alan's recommendation.

 So do I.

> The real problem is that the kernel confuses a CPU-level property
> (do the CPUs have TSCs?) with a system-level property (are the
> TSCs present and in sync?). CONFIG_X86_TSC really describes the
> latter property, for the former we have the cpu_has_tsc() macro.

 Well, CONFIG_X86_TSC simply asserts we have TSCs present and in sync and
cpu_has_tsc is a run-time check for the same.  The X86_FEATURE_TSC bit
shouldn't be set (and e.g. "notsc" takes care of this) unless TSCs work
correctly as it's both used internally and exported to the userland.  For
low-level fiddling with TSCs one can use cpuid either directly or with the
cpuid driver. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

