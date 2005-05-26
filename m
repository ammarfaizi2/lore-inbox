Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261652AbVEZRRC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261652AbVEZRRC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 13:17:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261616AbVEZRQu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 13:16:50 -0400
Received: from mail.dvmed.net ([216.237.124.58]:54234 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261652AbVEZRPh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 13:15:37 -0400
Message-ID: <42960436.4070106@pobox.com>
Date: Thu, 26 May 2005 13:15:34 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Playing with SATA NCQ
References: <20050526140058.GR1419@suse.de> <4295F87B.9070106@pobox.com> <20050526170658.GT1419@suse.de> <20050526171132.GV1419@suse.de>
In-Reply-To: <20050526171132.GV1419@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> Re-reading AHCI spec, it does indicate that you want to set SActive
> after building the command. I'll move it back, but keep the conditional
> of setting SActive on queued commands.

SActive is intentionally used for non-NCQ devices.  The SATA registers 
are -host- registers not -device- registers, remember.

At the very least, I would like to see a lot of testing before you make 
the current unconditional code conditional.

	Jeff


