Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269591AbUINR2W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269591AbUINR2W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 13:28:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269604AbUINR1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 13:27:42 -0400
Received: from ns9.hostinglmi.net ([213.194.149.146]:28068 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S269607AbUINRYp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 13:24:45 -0400
Date: Tue, 14 Sep 2004 19:26:46 +0200
From: DervishD <lkml@dervishd.net>
To: Tom Fredrik Blenning Klaussen <bfg-kernel@blenning.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: /proc/config reducing kernel image size
Message-ID: <20040914172646.GA614@DervishD>
Mail-Followup-To: Tom Fredrik Blenning Klaussen <bfg-kernel@blenning.no>,
	linux-kernel@vger.kernel.org
References: <1095179606.11939.22.camel@host-81-191-110-70.bluecom.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1095179606.11939.22.camel@host-81-191-110-70.bluecom.no>
User-Agent: Mutt/1.4.2.1i
Organization: DervishD
X-PopBeforeSMTPSenders: raul@dervishd.net
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ns9.hostinglmi.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - dervishd.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Tom :)

 * Tom Fredrik Blenning Klaussen <bfg-kernel@blenning.no> dixit:
> There is no point in storing all the comments and unused options in the
> kernel image. This typically reduces the config size to about 1/5th
> before compressing, and to about 1/4th after compressing.

    I'm with you in that there is no point in storing the comments,
but I disagree about the unused options. Storing the unused options
as comments is more useful than it seems ;)

    Look at this example. You want to know if you have 'CONFIG_PNP'
enabled, so you do something like 'grep CONFIG_PMP /proc/config' (the
typo PNP->PMP is intended here). Of course that commands doesn't
print anything due to the typo. If you store the disabled options as
comments and a grep fails, you probably mispelled the config option,
or you're referring to a config option not present in your old
kernel, but if you remove them and you mispell the config option
there is no (automatic) way of knowing if you made a typo or if the
option is disabled. Any automatic search can, potentially, give you a
false negative.

    I'm not really sure about it, but I think that the unset options
are left as comments for the sake of automation. The space saving
doesn't (IMHO) worth the pain.

> I've also added the configuration option of how you want to compress it.

    Compression is always welcome, I suppose ;) Thanks for the idea.

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.pleyades.net & http://raul.pleyades.net/
