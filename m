Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932173AbVIKOF6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932173AbVIKOF6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 10:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932221AbVIKOF6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 10:05:58 -0400
Received: from poros.telenet-ops.be ([195.130.132.44]:27014 "EHLO
	poros.telenet-ops.be") by vger.kernel.org with ESMTP
	id S932173AbVIKOF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 10:05:57 -0400
From: Jan De Luyck <lkml@kcore.org>
To: "Brown, Len" <len.brown@intel.com>
Subject: Re: battery status events (RE: Kernel 2.6.13 repeated ACPI events?)
Date: Sun, 11 Sep 2005 16:03:58 +0200
User-Agent: KMail/1.8.2
Cc: acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       "Lebedev, Vladimir P" <vladimir.p.lebedev@intel.com>,
       "Yu, Luming" <luming.yu@intel.com>
References: <F7DC2337C7631D4386A2DF6E8FB22B30048646E9@hdsmsx401.amr.corp.intel.com>
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B30048646E9@hdsmsx401.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509111603.58411.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 07 September 2005 22:10, Brown, Len wrote:
> The kernel doesn't created these messages -- presumably
> they're from acpid or some other user-level daemon
> that is monitoring /proc/acpi/event.  Unlikely that
> logging these events is necessary...
>
> Event 0x80 on the battery device is a "Battery Status Changed"
> which you'd expect to see when plugging/charging/discharging
> a battery.  How frequent they are depends on the rate,
> the battery and the firmware that is talking to it.

Ah, okay. I was under the impression that they should only be shown whenever 
there was an actual 'state' change, like battery is flat, is being charged, 
power is unplugged, not for the change of the charge level itself.

> Is there a GUI or something reading the battery status files?
> Do these events stop when running in text mode?

There is indeed klaptopdaemon running which does monitoring of the battery 
levens.

> Did this not happen on this box with earlier kernels?

I have no idea anymore when it started, but it wasn't there on a certain 
earlier kernel - but then i'm talking pre 2.6.7 era. I just didn't bother 
reporting it earlier, since I attributed it to a faulty dsdt line or so. I've 
read that ACER laptops have their share of bad dsdt's, that's why I didn't 
really bother - it works, it's just a tad annoying.
>
> Do the /proc/acpi/battery* files look sane --
> is the status really changing?

Yups, charge levels :)

Thanks, 

Jan

-- 
Food for thought is no substitute for the real thing.
		-- Walt Kelly, "Potluck Pogo"
