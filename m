Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316607AbSE0NZM>; Mon, 27 May 2002 09:25:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316608AbSE0NZL>; Mon, 27 May 2002 09:25:11 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:64252 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316611AbSE0NZK>; Mon, 27 May 2002 09:25:10 -0400
Subject: Re: i8259 and IO-APIC
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Terje Eggestad <terje.eggestad@scali.com>
Cc: Eric Lemoine <Eric.Lemoine@ens-lyon.fr>,
        linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1022502939.12203.81.camel@pc-16.office.scali.no>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 27 May 2002 15:27:01 +0100
Message-Id: <1022509621.11811.278.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-05-27 at 13:35, Terje Eggestad wrote:
> I'm a bit curious my self, in theory the IO_APIC should drastically
> reduce interrupt latency. An x86 has two interrupt pins, IRQ and NMI.

The APIC reduces processing overhead. The APIC bus on the pentium III is
pretty slow (I believe its a serial 4 wire bus or similar). On the
Athlon and Pentium IV it seems to be a lot faster.

In the case of a livelock the problem is probably the cost of handling
the IRQ and poking slowly at the chip. Latency is pretty immaterial here
compared with irq servicing overheads.

Alan

