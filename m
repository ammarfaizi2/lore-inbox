Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265151AbTLWPFq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 10:05:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265154AbTLWPFp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 10:05:45 -0500
Received: from 12-211-64-149.client.attbi.com ([12.211.64.149]:18563 "EHLO
	waltsathlon.localhost.net") by vger.kernel.org with ESMTP
	id S265151AbTLWPFo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 10:05:44 -0500
Message-ID: <3FE859C6.3070804@comcast.net>
Date: Tue, 23 Dec 2003 07:05:42 -0800
From: Walt H <waltabbyh@comcast.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031121
X-Accept-Language: en-us
MIME-Version: 1.0
To: Nicklas Bondesson <nikomail@hotmail.com>
Cc: linux-kernel@vger.kernel.org, "'Andre Hedrick'" <andre@linux-ide.org>
Subject: Re: Error mounting root fs on 72:01 using Promise FastTrak TX2000
 (PDC20271)
References: <BAY8-DAV6OZtJiGB75o000116e4@hotmail.com>
In-Reply-To: <BAY8-DAV6OZtJiGB75o000116e4@hotmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicklas Bondesson wrote:
> The fix for me was to disable all "Power Management" in the kernel and
> re-compile it. Works like a charm now :)
> 
> Hope this can help anyone else with the same problem as me. But again, I
> think someone should take a look at it cos I think this is a bug for sure.
> 
> /Nicke
> 

Nicke,

Glad to hear you got it working. Check out http://acpi.sourceforge.net for acpi
related information. If you can get it working with acpi=off and it doesn't when
you don't pass that flag, I'd say that there's at least something fishy
happening with acpi on your machine.

As for getting it running on 2.6 with dm, the only way I know of is to create a
custom initrd file by hand. You have to compile the lvm-dm tools statically and
create mappings first. Then in the linuxrc script, you need run dmsetup and
point it at the config files to create the devices. Until this is handled better
it's not really recommended. Good luck,

-Walt


