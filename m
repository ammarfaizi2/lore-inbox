Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267652AbTA1Tqt>; Tue, 28 Jan 2003 14:46:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267671AbTA1Tqt>; Tue, 28 Jan 2003 14:46:49 -0500
Received: from arnold.dormnet.his.se ([193.10.185.236]:44297 "HELO
	smtp.dormnet.his.se") by vger.kernel.org with SMTP
	id <S267652AbTA1Tqt>; Tue, 28 Jan 2003 14:46:49 -0500
Date: Tue, 28 Jan 2003 20:52:26 +0100
From: Andreas Henriksson <andreas@fjortis.info>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: OOPS in read_cd... what to do?
Message-ID: <20030128195226.GA27417@foo>
References: <Pine.GSO.4.33.0301270937370.18209-100000@Amps.coe.neu.edu> <3E355D1F.1080007@didntduck.org> <20030128125119.GA31590@foo> <1043779710.24849.8.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1043779710.24849.8.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi..

It didn't help. :(

Though I had to change it some to get it to compile... hopefully I
didn't screw up. (I did this to avoid "invalid operators to binary +")

#define virt_addr(addr) *(volatile unsigned char *) __io_virt(addr)
and changed the isa_...(foo+bar); to isa_...(virt_addr(foo+bar));

The oops looks about the same.. so I guess the patch didn't do any
difference (even if it might be needed in the long run)...

Any more ideas? ;)

 -- Andreas Henriksson
