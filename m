Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261153AbTFITB0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 15:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261872AbTFITB0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 15:01:26 -0400
Received: from main.gmane.org ([80.91.224.249]:38125 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261153AbTFITBZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 15:01:25 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Pasi Savolainen <psavo@iki.fi>
Subject: Re: 2.5.70-mm6
Date: Mon, 9 Jun 2003 19:07:30 +0000 (UTC)
Message-ID: <bc2lti$ss7$1@main.gmane.org>
References: <20030607151440.6982d8c6.akpm@digeo.com> <Pine.LNX.4.51.0306091943580.23392@dns.toxicfilms.tv>
X-Complaints-To: usenet@main.gmane.org
User-Agent: slrn/0.9.7.4 (Linux)
Cc: linux-mm@kvack.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Maciej Soltysiak <solt@dns.toxicfilms.tv>:
>> . -mm kernels will be running at HZ=100 for a while.  This is because
>>   the anticipatory scheduler's behaviour may be altered by the lower
>>   resolution.  Some architectures continue to use 100Hz and we need the
>>   testing coverage which x86 provides.
> The interactivity seems to have dropped. Again, with common desktop
> applications: xmms playing with ALSA, when choosing navigating through
> evolution options or browsing with opera, music skipps.
> X is running with nice -10, but with mm5 it ran smoothly.

I see that idle() is called much less often than before (1000
calls/second down to 150 calls/second, estimated and non-scientifical).

non-linear scale down is most probably because processes get more done
and don't wait so much.

idle() is also get called more when there is some load.

There is something weird though, I have this constant 0.8 load which I
can't pinpoint, in -mm4 fully idle machine was at about 0.1 load.

Regarding my stupidly reported Xfree86 -problem, it was PEBKAC, though I
can't tell what exactly that was. Only one module changed way to iterate
pci_find_device between boots.


-- 
   Psi -- <http://www.iki.fi/pasi.savolainen>

