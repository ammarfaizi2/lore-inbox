Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312548AbSCVO1p>; Fri, 22 Mar 2002 09:27:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312545AbSCVO1f>; Fri, 22 Mar 2002 09:27:35 -0500
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:35035 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S312540AbSCVO1U>; Fri, 22 Mar 2002 09:27:20 -0500
Date: Fri, 22 Mar 2002 15:23:30 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Dave Jones <davej@suse.de>
cc: Mikael Pettersson <mikpe@csd.uu.se>, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org, marcelo@conectiva.com.br,
        torvalds@transmeta.com
Subject: Re: [PATCH] boot_cpu_data corruption on SMP x86
In-Reply-To: <20020322085828.P22861@suse.de>
Message-ID: <Pine.GSO.3.96.1020322145646.21326A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Mar 2002, Dave Jones wrote:

>  > If say the BSP supports cpuid but an AP does not (possible for an
>  > i486 setup)
> 
>  It's also possible on any SMP aware system, but with the warning

 Nope, anything that provides cpuid will update the model and the stepping
correctly.

>  "you use asymetric CPUs, you get to keep the pieces". I don't recall
>  486's being any exception to this rule.

 Cpuid vs non-cpuid is a non-issue for the i486 -- the glue logic is
external as well as APICs and we don't care about the SMM, so no need to
unsupport it explicitly. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

