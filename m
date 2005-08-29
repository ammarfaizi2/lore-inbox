Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751204AbVH2H0I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbVH2H0I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 03:26:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbVH2H0I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 03:26:08 -0400
Received: from dgate1.fujitsu-siemens.com ([217.115.66.35]:30214 "EHLO
	dgate1.fujitsu-siemens.com") by vger.kernel.org with ESMTP
	id S1751204AbVH2H0H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 03:26:07 -0400
X-SBRSScore: None
Message-ID: <4312B87C.5040302@fujitsu-siemens.com>
Date: Mon, 29 Aug 2005 09:25:48 +0200
From: Martin Wilck <martin.wilck@fujitsu-siemens.com>
Organization: Fujitsu Siemens Computers
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: de, en-us, en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: yhlu <yhlu.kernel@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: APIC version and 8-bit APIC IDs
References: <42FC8461.2040102@fujitsu-siemens.com.suse.lists.linux.kernel>  <p73pssj2xdz.fsf@verdi.suse.de> <42FCA23C.7040601@fujitsu-siemens.com>  <20050812133248.GN8974@wotan.suse.de>  <42FCA97E.5010907@fujitsu-siemens.com>  <42FCB86C.5040509@fujitsu-siemens.com>  <20050812145725.GD922@wotan.suse.de>  <86802c44050812093774bf4816@mail.gmail.com>  <20050812164244.GC22901@wotan.suse.de> <86802c4405081210442b1bb840@mail.gmail.com> <43099FDF.6030504@fujitsu-siemens.com> <Pine.LNX.4.61L.0508231204510.2422@blysk.ds.pg.gda.pl> <430F20BF.1080703@fujitsu-siemens.com> <Pine.LNX.4.61L.0508261512520.9561@blysk.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.61L.0508261512520.9561@blysk.ds.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maciej W. Rozycki wrote:

>  You are unfortunately mistaken -- the spec is explicit about *local* APIC 
> IDs having to start at 0.  There are at least two places in the spec that 
> refer to that.

I see. Thanks for the clarification.

>  You can always assign 0, 16, 17, etc. to local APICs and then 1, 2, 3, 
> etc. for I/O APICs.  

Actually, that's what we did (I messed thinks up in my posting). I think 
that's an ugly configuration, though, and totally misleading in terms of 
system topology.

> Frankly I don't know what the actual justification 
> behind the requirement is.  Note that the ID of 0 need not necessarily 
> belong to the BSP.

Starting both local APICs and IO-APICs at 0 isa working and 
aesthetically pleasing solution. We're pursuing that now.

Thanks again, Martin

-- 
Martin Wilck                Phone: +49 5251 8 15113
Fujitsu Siemens Computers   Fax:   +49 5251 8 20409
Heinz-Nixdorf-Ring 1        mailto:Martin.Wilck@Fujitsu-Siemens.com
D-33106 Paderborn           http://www.fujitsu-siemens.com/primergy
