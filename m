Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265102AbTBGOE5>; Fri, 7 Feb 2003 09:04:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265250AbTBGOE4>; Fri, 7 Feb 2003 09:04:56 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:63167 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S265102AbTBGOE4>;
	Fri, 7 Feb 2003 09:04:56 -0500
Date: Fri, 7 Feb 2003 14:10:52 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: c1cc10 <c1cc10@autistici.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Cyrix III processor and kernel boot problem
Message-ID: <20030207141052.GA22687@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	c1cc10 <c1cc10@autistici.org>, linux-kernel@vger.kernel.org
References: <3E43C79A.2010506@autistici.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E43C79A.2010506@autistici.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 07, 2003 at 02:50:02PM +0000, c1cc10 wrote:
 > I've found out that the Cyrix III has no CMOV instruction and that this 
 > could be the problem.
 > So I compiled a pentium mmx version (after mrproper and dep) and all 
 > worked fine.
 > My question is: ok, it can't work if 686 compiled, but why does not it 
 > work also for the Cyrix III version?

The CyrixIII compile option should not generate cmov.
If you can objdump -D vmlinuz and grep for cmov, and find out
where thats being generated to confirm that it is that could be useful.

Which gcc did you use? And (silly question), did you make mrproper
before building the cyrix3 kernel ? If there were left behind .o
files, that could confuse it. Possibly ccache too.
if you were using that rm -rf ~/.ccache to be sure.

as a sidenote, the new C3s (Nehemiah) now have CMOV.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
