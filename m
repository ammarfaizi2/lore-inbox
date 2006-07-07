Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751151AbWGGCqM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbWGGCqM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 22:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbWGGCqM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 22:46:12 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:38621 "EHLO
	out2.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1751151AbWGGCqL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 22:46:11 -0400
X-Sasl-enc: uXFFqPTmWdKuFaRPNhtvSGBxuldgdcng4jRcT8//t1f2 1152240371
Date: Thu, 6 Jul 2006 23:46:04 -0300
From: Henrique de Moraes Holschuh <hmh@debian.org>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Robert Hancock <hancockr@shaw.ca>, Pavel Machek <pavel@suse.cz>,
       lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org,
       hdaps-devel@lists.sourceforge.net, Stelian Pop <stelian@popies.net>,
       Michael Hanselmann <linux-kernel@hansmi.ch>
Subject: Re: Generic interface for accelerometers (AMS, HDAPS, ...)
Message-ID: <20060707024603.GC22666@khazad-dum.debian.net>
References: <fa.GOQkHC8inXir2wbg4bZayOWXzAY@ifi.uio.no> <fa.qLWuLxQd7Mhcnixy/TLVs/nPwig@ifi.uio.no> <44AC5261.9050708@shaw.ca> <20060706061930.GA6033@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060706061930.GA6033@suse.cz>
X-GPG-Fingerprint: 1024D/1CDB0FE3 5422 5C61 F6B7 06FB 7E04  3738 EE25 DE3F 1CDB 0FE3
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Jul 2006, Vojtech Pavlik wrote:
> > >We are investigating the ACPI global lock as a way to at least get the
> > >SMBIOS to stay away from the EC while we talk to it, but we don't know if
> > >the entire SMBIOS firmware respects that lock.
> > 
> > It had better, that is exactly what the ACPI Global Lock is supposed to 
> > prevent (concurrent access to non-sharable resources between the OS and 
> > SMI code). The ACPI DSDT contains information on whether or not the 
> > machine requires the Global Lock in order to access the EC or whether it 
> > is safe to access without locking.
>  
> Isn't that vaild only if you actully use ACPI to access the EC? (AFAIK
> the HDAPS driver does direct port access.)

It better be valid for any OS-side access to the EC, otherwise the ACPI
global lock would be utterly useless.  The system vendor would have done its
own "global-lock-like" functionality without the need for an ACPI global
lock specification.

What is not clear to me is whether an ACPI DSDT method is on the "OS side"
or on the "SMM side" of the ACPI global lock.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
