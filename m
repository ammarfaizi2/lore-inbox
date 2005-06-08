Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261529AbVFHSwk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261529AbVFHSwk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 14:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261527AbVFHSwk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 14:52:40 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:25604 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S261522AbVFHSwc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 14:52:32 -0400
Message-ID: <42A73E6E.80808@rtr.ca>
Date: Wed, 08 Jun 2005 14:52:30 -0400
From: Mark Lord <liml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.7) Gecko/20050420 Debian/1.7.7-2
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Greg Stark <gsstark@mit.edu>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: SMART support for libata
References: <87y8g8r4y6.fsf@stark.xeocode.com> <41B7EFA3.8000007@pobox.com> <87br6g6ayr.fsf@stark.xeocode.com>
In-Reply-To: <87br6g6ayr.fsf@stark.xeocode.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Stark wrote:
>
> getting really hot so I put it to sleep with "hdparm -Y".
> 
> Now whenever smartd probes that drive my system freezes for a few seconds and
> I get this in my syslog:
> 
> Jun  8 12:49:36 stark kernel: hda: status timeout: status=0xd0 { Busy }
> Jun  8 12:49:36 stark kernel: 
> Jun  8 12:49:36 stark kernel: ide: failed opcode was: 0xe5

That is normal and expected behaviour.
A "sleeping" drive never responds to commands
until woken with a reset.

You should be using "-y" (standby) instead of "-Y" (sleep).

Cheers
