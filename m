Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317523AbSFEBCY>; Tue, 4 Jun 2002 21:02:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317524AbSFEBCX>; Tue, 4 Jun 2002 21:02:23 -0400
Received: from ns.suse.de ([213.95.15.193]:44553 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S317523AbSFEBCW>;
	Tue, 4 Jun 2002 21:02:22 -0400
Date: Wed, 5 Jun 2002 03:02:23 +0200
From: Dave Jones <davej@suse.de>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: linux-kernel@vger.kernel.org, arjanv@redhat.com
Subject: Re: 2.4.19-pre10-ac1: Hardcoded cpu_khz in powernow-k6.c
Message-ID: <20020605030223.A5277@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Adrian Bunk <bunk@fs.tum.de>, linux-kernel@vger.kernel.org,
	arjanv@redhat.com
In-Reply-To: <Pine.NEB.4.44.0206050236260.9994-100000@mimas.fachschaften.tu-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 05, 2002 at 02:52:15AM +0200, Adrian Bunk wrote:
 > Hi Dave,
 > 
 > while reading through powernow-k6.c in 2.4.19-pre10-ac1 I found the
 > following that seems to be a bug:
 > 
 >   static unsigned long cpu_khz=350000;
 > 
 > Not every K6-2/3 runs at 350 MHz...

iirc, there aren't any MSRs[*] on the K6-2 where we can read
the current FSB.  I think 350MHz was used as it was probably
the slowest K6-2 to be found at the time.  You can override
it with boot time arguments.

    Dave.

[*] The K6 style powernow was reverse engineered, as there were
no publically available documents explaining it. All we can
do is scale multipliers. No voltage scaling, no FSB decoding.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
