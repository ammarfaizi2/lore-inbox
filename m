Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261691AbVE3Ssm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261691AbVE3Ssm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 14:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261694AbVE3Ssc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 14:48:32 -0400
Received: from mail.dvmed.net ([216.237.124.58]:41707 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261691AbVE3SsO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 14:48:14 -0400
Message-ID: <429B5FE3.8070908@pobox.com>
Date: Mon, 30 May 2005 14:48:03 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Lord <liml@rtr.ca>, Erik Slagter <erik@slagter.name>,
       Michael Thonke <iogl64nx@gmail.com>
CC: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: Playing with SATA NCQ
References: <20050526140058.GR1419@suse.de>	 <1117382598.4851.3.camel@localhost.localdomain>	 <4299F47B.5020603@gmail.com>	 <1117387591.4851.17.camel@localhost.localdomain> <429A58F4.3040308@rtr.ca>	 <1117438192.4851.29.camel@localhost.localdomain>  <429B56CA.5080803@rtr.ca> <1117477364.3108.2.camel@localhost.localdomain> <429B5A94.6010301@rtr.ca>
In-Reply-To: <429B5A94.6010301@rtr.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:
> Erik Slagter wrote:>
> 
>> Still I'd like to run in ACHI mode ;-)
> 
> 
> Me too!  But from reading the ICH6 Intel docs,
> it seems that AHCI mode is only for true SATA drives.

Correct.  AHCI mode absolutely requires SATA, because it only supports 
the native SATA "FIS" packets.

As much as I would like, one cannot use AHCI to talk to any PATA device[1].

	Jeff



[1] unless it's PATA bridged over SATA, the exception case that turns 
any PATA device into a SATA device.
