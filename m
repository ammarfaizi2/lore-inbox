Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270803AbTHKA3F (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 20:29:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270805AbTHKA3F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 20:29:05 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64425 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S270803AbTHKA3D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 20:29:03 -0400
Message-ID: <3F36E340.2020701@pobox.com>
Date: Sun, 10 Aug 2003 20:28:48 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Albert Cahalan <albert@users.sf.net>
CC: linux-kernel mailing list <linux-kernel@vger.kernel.org>, mikpe@csd.uu.se,
       m.c.p@wolk-project.de
Subject: Re: [patch 2.4 1/2] backport 2.6 x86 cpu capabilities
References: <1060559943.948.121.camel@cube>
In-Reply-To: <1060559943.948.121.camel@cube>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cahalan wrote:
> Mikael Pettersson writes:
> 
> 
>>2.4.21-rc1 with NCAPINTS==6 hangs at boot in the local
>>APIC timer calibration step; before that it detected a
>>0MHz bus clock and the local APIC NMI watchdog was stuck.
>>Correcting head.S:X86_VENDOR_ID fixes these problems.
>>
>>Without correcting head.S:X86_VENDOR_ID, head.S will store
>>the vendor id partly in the capabilities array. This breaks
>>both the capabilities and the vendor id. I can't say why 2.6
>>works, but obviously the CPU setup code has changed since 2.4.
> 
> 
> I may be stating the obvious, but in case not...
> 
> If Jeff Garzik missed this, others will too. I hope
> that a big comment gets added in both places, assuming
> that automatic offset generation isn't practical.


Yeah, I'm queueing a change to do that, actually, so that a grep for 
NCAPINTS will hit head.S.

	Jeff



