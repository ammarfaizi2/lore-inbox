Return-Path: <linux-kernel-owner+w=401wt.eu-S1030205AbXADTpc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030205AbXADTpc (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 14:45:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030206AbXADTpb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 14:45:31 -0500
Received: from hera.kernel.org ([140.211.167.34]:54019 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030205AbXADTpa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 14:45:30 -0500
From: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [Dumb question] 100k RTC interrupts/sec on SMP system: why?
Date: Thu, 4 Jan 2007 14:44:45 -0500
User-Agent: KMail/1.9.5
Cc: Paul P Komkoff Jr <i@stingr.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20061109100953.GE2226@stingr.net> <20061110133504.GC18001@stingr.net> <1163166183.3138.707.camel@laptopd505.fenrus.org>
In-Reply-To: <1163166183.3138.707.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701041444.45250.lenb@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 10 November 2006 08:43, Arjan van de Ven wrote:
> On Fri, 2006-11-10 at 16:35 +0300, Paul P Komkoff Jr wrote:
> > Replying to Arjan van de Ven:
> > > Also have you tried acpi=off or the linux firmware test kit (see url in
> > 
> > acpi=off fixed this.
> >   8:          1          0    IO-APIC-edge  rtc
> acpi=on had this
> 
> >  8: 3673166897 3674697116   IO-APIC-level  rtc
> 
> spot the level-vs-edge difference.... your acpi interrupt routing looks
> bust.
> 
> 
> > So I got rid of "interrupt storm" but what I've lost (except poweroff)?
> 
> you can get power off with APM as well.

Servers don't have APM.

It seems this is an additional sighting of this BIOS bug:

http://bugzilla.kernel.org/show_bug.cgi?id=7679

(perhaps you can note that in the bug report)

pnpacpi=off should be a sufficient workaround for now.

thanks,
-Len

ps. there is nothing dumb about this question:-)
