Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312533AbSCVGxi>; Fri, 22 Mar 2002 01:53:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312701AbSCVGx2>; Fri, 22 Mar 2002 01:53:28 -0500
Received: from pec-92-174.tnt5.f.uunet.de ([149.225.92.174]:59652 "EHLO
	dd8ne.ofr.de.ampr.org") by vger.kernel.org with ESMTP
	id <S312533AbSCVGxT> convert rfc822-to-8bit; Fri, 22 Mar 2002 01:53:19 -0500
From: Hans-Joachim Hetscher <hans-joachim@hetscher.bnv-bamberg.de>
Date: Fri, 22 Mar 2002 06:53:48 GMT
Message-ID: <20020322.6534800@dd8ne.ofr.de.ampr.org>
Subject: Re: 2.5.7 does not compile
To: davej@suse.de (Dave Jones), linux-kernel@vger.kernel.org
Reply-To: dd8ne@bnv-bamberg.de
In-Reply-To: <20020321173953.F22861@suse.de>
X-Mailer: Mozilla/3.0 (compatible; StarOffice/5.2;Linux)
X-Priority: 3 (Normal)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO_8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo,

It seeems to be the same bug in 6pack.c

So, I solved the problem in line 259 of 6pack.c by changing

dev->last_rx = jiffies;

into 

sp->dev->last_rx = jiffies; 



>>>>>>>>>>>>>>>>>> Ursprüngliche Nachricht <<<<<<<<<<<<<<<<<<

Am 21.03.02, 17:45:01, schrieb davej@suse.de (Dave Jones) zum Thema Re: 
2.5.7 does not compile:


> On Thu, Mar 21, 2002 at 05:15:49PM +0100, Jean-Luc Coulon wrote:
>  > -DKBUILD_BASENAME=scc  -c -o scc.o scc.c
>  > scc.c: In function `scc_net_rx':
>  > scc.c:1664: `dev' undeclared (first use in this function)

> Line should read..

> scc->dev->last_rx = jiffies;

vy 73 de Hans-Joachim

-- 

 DD8NE   : Hans-Joachim Hetscher    IP-Adr. : [44.130.62.1] 
 amprNet : dd8ne@db0lj.ampr.org     AX25    :DD8NE@DB0LJ.#RPL.DEU.EU 
 Internet: dd8ne@bnv-bamberg.de     hans-joachim.hetscher@de.michelin.com
