Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261917AbTEZRlw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 13:41:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261906AbTEZRlw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 13:41:52 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13496 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261917AbTEZRlj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 13:41:39 -0400
Message-ID: <3ED254DE.5020308@pobox.com>
Date: Mon, 26 May 2003 13:54:38 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCHES] add ata scsi driver
References: <3ED1B261.8030708@pobox.com> <Pine.LNX.4.44.0305260956590.11328-100000@home.transmeta.com> <20030526172405.GJ845@suse.de>
In-Reply-To: <20030526172405.GJ845@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Mon, May 26 2003, Linus Torvalds wrote:
> 
>>>What does the block layer need, that it doesn't have now?
>>
>>Exactly. I'd _love_ for people to really think about this.
> 
> 
> In discussion with Jeff, it seems most of what he wants is already
> there. He just doesn't know it yet :-)


hehe.  Here's a salient point:

native block drivers are typically used in one of two ways:  creating a 
whole subsystem (ide, scsi), or servicing a single host (dac960).

I am doing the first:  creating a whole subsystem.  The infrastructure 
involved in that, over and above what block already provides, is that 
part I dread coding.

If I am to code that, I want to do so ONCE.  And that means a 
bus-agnostic /dev/{disk,cdrom,tape}.  Not /dev/{ad,acd,at,ag}.

	Jeff


