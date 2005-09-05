Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932342AbVIEQoK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932342AbVIEQoK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 12:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932344AbVIEQoK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 12:44:10 -0400
Received: from orb.pobox.com ([207.8.226.5]:54757 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S932342AbVIEQoJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 12:44:09 -0400
Message-ID: <431C75D6.6050703@rtr.ca>
Date: Mon, 05 Sep 2005 12:44:06 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050728
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Oliver Tennert <O.Tennert@science-computing.de>,
       linux-kernel@vger.kernel.org
Subject: Re: DVD+-R[W] regression in 2.6.12/13
References: <200509051533.01465.tennert@science-computing.de>	 <431C7131.3030506@rtr.ca> <1125939771.8714.29.camel@localhost.localdomain>
In-Reply-To: <1125939771.8714.29.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Llu, 2005-09-05 at 12:24 -0400, Mark Lord wrote:
> 
>>I'm not sure why the "failed: Input/output error" (-EIO) result is
>>being returned from the ATA layer in this case.  Driver bug, most likely.
> 
> Because the command failed an error was reported back instead of success
> status/info.

Well, yes, that's -EIO, as expected from the IDENTIFY command.
But the PACKET_IDENTIFY should not be failing on the ATAPI drive.

-ml
