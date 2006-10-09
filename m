Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751721AbWJISQW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751721AbWJISQW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 14:16:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751643AbWJISQW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 14:16:22 -0400
Received: from mail.gmx.net ([213.165.64.20]:29393 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751214AbWJISQW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 14:16:22 -0400
X-Authenticated: #1045983
From: Helge Deller <deller@gmx.de>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] [kernel/ subdirectory] constifications
Date: Mon, 9 Oct 2006 20:16:18 +0200
User-Agent: KMail/1.9.5
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200610082121.49925.deller@gmx.de> <1160377169.3000.189.camel@laptopd505.fenrus.org>
In-Reply-To: <1160377169.3000.189.camel@laptopd505.fenrus.org>
X-Face: *4/{KL3=jWs!v\UO#3e7~Vb1~CL@oP'~|*/M$!9`tb2[;fY@)WscF2iV7`,a$141g'o,=?utf-8?q?7X=0A=09=3FBt1Wb=3AL7K6z-?=<?-+-13|S_ixrq58*E`)ZkSe~NSI?u=89G'J<n]7\?[)LCCBZc}~[j(=?utf-8?q?e=7D=0A=09=60-QV=7B=23=25=26=5B=3F=5EfAke6t8QbP=3Bb=27XB?=,ZU84HeThMrO(@/K.`jxq9P({V(AzezCKMxk\F2^p^+"=?utf-8?q?=0A=09=5B?="ppalbA!zy-l)^Qa3*u/Z-1W3,o?2fes2_d\u=1\E9N+~Qo
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610092016.18362.deller@gmx.de>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 09 October 2006 08:59, Arjan van de Ven wrote:
> On Sun, 2006-10-08 at 21:21 +0200, Helge Deller wrote:
> > - completely constify string arrays,  thus move them to the rodata section
> 
> note that gcc 4.1 and later will do this automatically for static things
> at least...

Are you sure ?

At least with gcc-4.1.0 from SUSE 10.1 the strings array _pointers_ are not moved into the rodata section without the second "const":
const static char * const x[] = { "value1", "value2" };

Helge
