Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264275AbTDKAPk (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 20:15:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264276AbTDKAPk (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 20:15:40 -0400
Received: from palrel11.hp.com ([156.153.255.246]:14753 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S264275AbTDKAPk (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 20:15:40 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16022.3049.182240.580692@napali.hpl.hp.com>
Date: Thu, 10 Apr 2003 17:27:21 -0700
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: davidm@hpl.hp.com, akpm@zip.com.au,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: proc_misc.c bug
In-Reply-To: <1050011057.12930.134.camel@dhcp22.swansea.linux.org.uk>
References: <200304102202.h3AM2YH3021747@napali.hpl.hp.com>
	<1050011057.12930.134.camel@dhcp22.swansea.linux.org.uk>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On 10 Apr 2003 22:44:17 +0100, Alan Cox <alan@lxorguk.ukuu.org.uk> said:

  Alan> On Thu, 2003-04-10 at 23:02, David Mosberger wrote:
  >> The workaround below is to allocate 4KB per 8 CPUs.  Not really a
  >> solution, but the fundamental problem is that /proc/interrupts
  >> shouldn't use a fixed buffer size in the first place.  I suppose
  >> another solution would be to use vmalloc() instead.  It all feels like
  >> bandaids though.

  Alan> How about switching to Al's seqfile interface ?

That's obviously the non-bandaid solution I was hinting at.  Any volunteers?

	--david
