Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261538AbSJBAao>; Tue, 1 Oct 2002 20:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261870AbSJBAan>; Tue, 1 Oct 2002 20:30:43 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:14583 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261538AbSJBAam>; Tue, 1 Oct 2002 20:30:42 -0400
Subject: Re: [patch][rfc] xquad_portio cleanup
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: colpatch@us.ibm.com
Cc: Dave Jones <davej@codemonkey.org.uk>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Martin Bligh <mjbligh@us.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <3D9A173B.1010205@us.ibm.com>
References: <3D98DFA0.6020908@us.ibm.com> <20021001152148.GA126@suse.de> 
	<3D9A173B.1010205@us.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 02 Oct 2002 01:43:03 +0100
Message-Id: <1033519383.20103.36.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-10-01 at 22:44, Matthew Dobson wrote:
> > STANDALONE seems to be a very namespace-polluting choice of define.
> > MULTIQUAD_STANDALONE, MQ_STANDALONE... anything would be better imo.
> 
> The #define is most definitely *not* NUMA/Multiquad specific.  In this
> particular instance, it is guarding Multiquad specific code...  The 
> STANDALONE option (please clarify if I'm wrong, Alan) is for code that 
> is compiled along with the kernel, with the kernel headers, etc, but is 
> not acually part of the kernel proper.

Indeed

Its set by the boot loader code that wants to also use inb/outb etc but
not get the kernel magic wonders of numa-q and other evil abuses of PC
iomapping 

