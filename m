Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268696AbUIXLnW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268696AbUIXLnW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 07:43:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268697AbUIXLnW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 07:43:22 -0400
Received: from port-212-202-157-208.static.qsc.de ([212.202.157.208]:55964
	"EHLO zoidberg.portrix.net") by vger.kernel.org with ESMTP
	id S268696AbUIXLnR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 07:43:17 -0400
Message-ID: <4154083B.6040109@ppp0.net>
Date: Fri, 24 Sep 2004 13:42:51 +0200
From: Jan Dittmer <jdittmer@ppp0.net>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040830)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
CC: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>,
       Hotplug List <pcihpd-discuss@lists.sourceforge.net>
Subject: Re: Is there a user space pci rescan method?
References: <E8F8DBCB0468204E856114A2CD20741F2C13E2@mail.local.ActualitySystems.com> <4152FFA0.9020005@ppp0.net> <200409231905.47279@bilbo.math.uni-mannheim.de> <200409241241.19654@bilbo.math.uni-mannheim.de>
In-Reply-To: <200409241241.19654@bilbo.math.uni-mannheim.de>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rolf Eike Beer wrote:
> Ok, here we go. This is my current diff that I use for my tests at home. It adds
> dummyphp and cleans up fakephp a lot (read: kills it). Changes from last version:
> 
> -removed some dead comments
> -removed some unused instructions
> -reordered allocation in add_slot to do less memory allocations if there is
>  no device in slot
> -changed param "usedonly" to "showunused" so it behaves like fakephp at the
>  first look: if you load dummyphp without parameters there are only slots with
>  devices in it.
> -removed "DUMMY-" prefix to entries in /sys/bus/pci/slots/
> 
> Please send comments so I can send it for inclusion soon.

Well, first of all I think you should just submit a patch to add dummyphp and not
removing fakephp in the same step. Also you somehow mis-copied the patch to
your mail app - most (not all) tabs are converted to one space (or is it just
thunderbird displaying the mail?). Can you resend it? Then I'll give it a try.
Greg wrote in another mail that the 'proper' way of 'powering up' device slots should
be to rescan the entire bus. I don't know, your approach certainly seems easier, but you
are bound to either display all pci slots which may come to live or just the ones
in the system already, which means you cannot rescan slots which weren't equipped
on boot up. So perhaps adding a rescan method to fakephp is indeed cleaner.

Jan
