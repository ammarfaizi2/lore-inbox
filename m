Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750920AbVJFNbx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750920AbVJFNbx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 09:31:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750918AbVJFNbx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 09:31:53 -0400
Received: from mailhub.lss.emc.com ([168.159.2.31]:59206 "EHLO
	mailhub.lss.emc.com") by vger.kernel.org with ESMTP
	id S1750913AbVJFNbw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 09:31:52 -0400
Message-ID: <4345273B.40906@emc.com>
Date: Thu, 06 Oct 2005 09:31:39 -0400
From: Brett Russ <russb@emc.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Bogdan Costescu <Bogdan.Costescu@iwr.uni-heidelberg.de>,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.14-rc2 0/2] libata: Marvell SATA support (v0.23-0.24)
References: <20051005210610.EC31826369@lns1058.lss.emc.com> <Pine.LNX.4.63.0510061441050.3140@dingo.iwr.uni-heidelberg.de> <43452315.7050801@pobox.com>
In-Reply-To: <43452315.7050801@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-PMX-Version: 4.7.1.128075, Antispam-Engine: 2.1.0.0, Antispam-Data: 2005.10.6.10
X-PerlMx-Spam: Gauge=, SPAM=7%, Reasons='EMC_FROM_00+ 0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0, __USER_AGENT 0'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Staring at the docs a bit, I notice that the 50xx and 60xx have SATA 
> S{status,control,error} registers at different locations.


Yes and also even some registers that are at the same location have 
changed bit definitions.  Aye caramba.

Best solution will probably be to create separate enums for each chip 
generation, in addition to a common enum, and point to the relevant one 
based on the chip identifier.

No surprise we're seeing so many problems.  I have just not spent any 
time at all on 5xxx.  Probably should yank it from the pci device table 
for now.

BR
