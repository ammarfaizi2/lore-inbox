Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129383AbRAXWK6>; Wed, 24 Jan 2001 17:10:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130362AbRAXWKt>; Wed, 24 Jan 2001 17:10:49 -0500
Received: from w240.z209220232.was-dc.dsl.cnc.net ([209.220.232.240]:11015
	"EHLO yendi.dmeyer.net") by vger.kernel.org with ESMTP
	id <S129383AbRAXWKo>; Wed, 24 Jan 2001 17:10:44 -0500
Date: Wed, 24 Jan 2001 17:10:42 -0500
From: dmeyer@dmeyer.net
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: acpi@phobos.fachschaften.tu-muenchen.de,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: ACPI trouble with MS-6167 motherboard (fwd)
Message-ID: <20010124171042.A7880@jhereg.dmeyer.net>
Reply-To: dmeyer@dmeyer.net
In-Reply-To: <4148FEAAD879D311AC5700A0C969E8905DE5D4@orsmsx35.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <4148FEAAD879D311AC5700A0C969E8905DE5D4@orsmsx35.jf.intel.com>; from andrew.grover@intel.com on Wed, Jan 24, 2001 at 01:54:48PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

According to Grover, Andrew:
> This is pretty weird, since the latest ACPI update went in pre10, and it was
> pretty minor. That you are saying problems started in pre8 implies this is
> not a problem with the ACPI driver, but something else.. hmm..
> 
> So it worked in pre7 and broke in pre8?

I didn't try kernels between 2.4.0 and pre8, so I'm not sure when it
broke.  I suppose I could <shudder> try to narrow down exactly which
pre patch started to show the problem.

Actually, looking back at /var/log/messages, it's even worse than I
originally said.  It looks like for at least some early builds of
2.4.0 I was getting:

Jan  5 16:39:18 jhereg kernel: ACPI: System description tables found
Jan  5 16:39:18 jhereg kernel: ACPI: System description tables loaded
Jan  5 16:39:18 jhereg kernel:     ACPI-0281: *** Error: Ns_search_and_enter: Bad character in ACPI Name
Jan  5 16:39:18 jhereg kernel:     ACPI-0281: *** Error: Ns_search_and_enter: Bad character in ACPI Name
Jan  5 16:39:18 jhereg kernel: ACPI: Subsystem enable failed

Although for later 2.4.0 builds it worked OK.  I wonder what could be
doing this?  About the only things I played with during 2.4.0 builds
was updated reiserfs and LVM patches.

-- 
David M. Meyer
dmeyer@dmeyer.net
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
