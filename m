Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311343AbSCLVAY>; Tue, 12 Mar 2002 16:00:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311344AbSCLVAP>; Tue, 12 Mar 2002 16:00:15 -0500
Received: from ns.suse.de ([213.95.15.193]:59913 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S311343AbSCLVAC>;
	Tue, 12 Mar 2002 16:00:02 -0500
Date: Tue, 12 Mar 2002 22:00:00 +0100
From: Dave Jones <davej@suse.de>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19-pre3
Message-ID: <20020312215959.D30825@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Mikael Pettersson <mikpe@csd.uu.se>, marcelo@conectiva.com.br,
	linux-kernel@vger.kernel.org
In-Reply-To: <200203120051.BAA20236@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200203120051.BAA20236@harpo.it.uu.se>; from mikpe@csd.uu.se on Tue, Mar 12, 2002 at 01:51:42AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2002 at 01:51:42AM +0100, Mikael Pettersson wrote:
 > >- Fix off-by-one error in bluesmoke			(Dave Jones)
 > NO NO NO! This is the same broken patch that somehow got into
 > 2.2.21pre4 as well.
 
 Agreed, it should get backed out as it was in 2.2.21rc1

 > The patch changes the code to write to the
 > IA32_MC0_CTL MSR, which is a big no-no. Intel's IA32 Vol3 manual
 > (#245472-03) sections 13.3.2.1 and 13.5 make that point quite clear.

 Without the change however, Athlons won't report Icache errors.
 Possibly we need a seperate init path for Athlon/Intel
 
-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
