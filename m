Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932420AbVIFGkG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932420AbVIFGkG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 02:40:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932421AbVIFGkG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 02:40:06 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:53997 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S932420AbVIFGkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 02:40:05 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Andi Kleen <ak@suse.de>
Subject: Re: RFC: i386: kill !4KSTACKS
Date: Tue, 6 Sep 2005 09:39:27 +0300
User-Agent: KMail/1.8.2
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
References: <20050904145129.53730.qmail@web50202.mail.yahoo.com> <1125854398.23858.51.camel@localhost.localdomain> <p73aciqrev0.fsf@verdi.suse.de>
In-Reply-To: <p73aciqrev0.fsf@verdi.suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509060939.28055.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 06 September 2005 07:37, Andi Kleen wrote:
> Running with tight stack is just a fundamentally fragile configuration
> and will come back to bite you later. Even with 8k we regularly
> had overflows reported and with 4k it will be much worse.

I think one of the reasons is:

"No matter how big stack is, there are always careless
code which can overflow it. 4k, 8k, 64k (hypotetically),
we still must keep stack size in mind when coding.

So, since we already are writing stack size aware code,
why not pick minimum realistically working stack size? Looks
like we can make 4k stack work, and it's naturally smallest
sensible (and in fact easiest to allocate/manage) stack for i386.
So be it, let's use 4k."

I suspect Windows went the opposite way. I bet they already went
thru several iterations of "ouch these drivers from BogoSoft
can overflow stack on nt N, let's bump up stack size for
our new shiny nt N+1".
--
vda
