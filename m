Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265343AbTLSFjL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 00:39:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265344AbTLSFjL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 00:39:11 -0500
Received: from secure.comcen.com.au ([203.23.236.73]:35339 "EHLO
	xavier.etalk.net.au") by vger.kernel.org with ESMTP id S265343AbTLSFjI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 00:39:08 -0500
From: Ross Dickson <ross@datscreative.com.au>
Reply-To: ross@datscreative.com.au
Organization: Dat's Creative Pty Ltd
To: Craig Bradney <cbradney@zip.com.au>,
       "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Subject: Re: Catching NForce2 lockup with NMI watchdog
Date: Fri, 19 Dec 2003 15:38:34 +1000
User-Agent: KMail/1.5.1
Cc: george@mvista.com, linux-kernel@vger.kernel.org
References: <200312180414.17925.ross@datscreative.com.au> <Pine.LNX.4.55.0312181347540.23601@jurand.ds.pg.gda.pl> <1071757363.18749.42.camel@athlonxp.bradney.info>
In-Reply-To: <1071757363.18749.42.camel@athlonxp.bradney.info>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312191538.34551.ross@datscreative.com.au>
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 19 December 2003 00:22, Craig Bradney wrote:
> Just as an FYI, still going strong here with the old api and ioapic
> patches. 5d 20h now.
> 
> When the official 2.6.0 comes to Gentoo Linux I can try that with
> whatever patches people are finding stable for these nforce fixes.
> 
> Anyone had any luck in talking to ASUS re a BIOS update?
> 
> Craig
> 

I have not talked to ASUS. I note from peoples postings that with the
latest award bios we may need no apic patches (C1 disconnect auto),
just an ioapic one to work round a buggy bios. I don't think you can run
nmi_watchdog=1 with the old io-apic (not of my doing) patch.

I have pheonix bios MOBOS from albatron and epox so award bios doesn't help me.
No disconnect options available in setup.
My apic ack delay patch lets the bios have its disconnect on and keep the cpu a
few degrees cooler besides whatever else it and the nforce2 chipset might want
to control it for.

I have been advised my query wrt my apic ack delay patch is progressing
with AMD but I have nothing technical to report on it.

I have made and am trialling, but have not yet posted a kernel arg controlled
version combining my v1 and v2 apic ack delay patches. This would be better
than what I have released in the past because people can fix bioses as the
fixes become available and use timer ack delay in the mean time.
Of course there is still athcool and the earlier disconnect patch to force 
things if desired.

Regards
Ross.
