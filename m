Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263963AbUEMPS5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263963AbUEMPS5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 11:18:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264254AbUEMPSj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 11:18:39 -0400
Received: from mtaw4.prodigy.net ([64.164.98.52]:41934 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S263963AbUEMPRM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 11:17:12 -0400
Message-ID: <40A390B3.1020401@pacbell.net>
Date: Thu, 13 May 2004 08:13:55 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Ari Pollak <ajp@aripollak.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm-rc3-mm2 USB 2.0 after suspend issue
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You said  2.6.6-rc3-mm2 gives you these strange
messages, but how does 2.6.6-mm2 behave?

> ehci_hcd 0000:00:1d.7: suspend D0 --> D3
> ehci_hcd 0000:00:1d.7: No PM capability

2.6.6-mm2 won't give that message pair.  The EHCI
suspend/resume should work better though.

> uhci_hcd 0000:00:1d.2: suspend D4 --> D3
> uhci_hcd 0000:00:1d.2: suspend_hc
> uhci_hcd 0000:00:1d.1: suspend D4 --> D3
> uhci_hcd 0000:00:1d.1: suspend_hc
> uhci_hcd 0000:00:1d.0: suspend D4 --> D3
> uhci_hcd 0000:00:1d.0: suspend_hc

Those messages are a bit strange.  If it still
misbehaves in 2.6.6-mm2, please send "lspci -vv"
info for these USB controllers.  (Preferably
to linux-usb-devel, where it's easier to see.)

> ...
> ehci_hcd 0000:00:1d.7: resume from state D0
> ehci_hcd 0000:00:1d.7: can't resume, not suspended!

Again, 2.6.6-mm2 shouldn't do that.

- Dave


