Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262144AbTEZTER (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 15:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262145AbTEZTEQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 15:04:16 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:58118 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262144AbTEZTEP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 15:04:15 -0400
Subject: Re: [BK PATCHES] add ata scsi driver
From: James Bottomley <James.Bottomley@steeleye.com>
To: Jens Axboe <axboe@suse.de>
Cc: torvalds@transmeta.com, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030526190707.GM845@suse.de>
References: <1053972773.2298.177.camel@mulgrave>
	<20030526181852.GL845@suse.de> <1053974830.1768.190.camel@mulgrave> 
	<20030526190707.GM845@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 26 May 2003 15:17:23 -0400
Message-Id: <1053976644.2298.194.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-05-26 at 15:07, Jens Axboe wrote:
> Alright, so what do you need? Start out with X tags, shrink to Y (based
> on repeated queue full conditions)? Anything else?

Actually, it's easier than that: just an API to alter the number of tags
in the block layer (really only the size of your internal hash table). 
The actual heuristics of when to alter the queue depth is the province
of the individual drivers (although Doug Ledford was going to come up
with a generic implementation).

James


