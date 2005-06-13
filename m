Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261797AbVFMQsl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261797AbVFMQsl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 12:48:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261855AbVFMQsk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 12:48:40 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:42918 "EHLO
	zcars04e.ca.nortel.com") by vger.kernel.org with ESMTP
	id S261797AbVFMQs3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 12:48:29 -0400
Message-ID: <42ADB8D1.9090503@nortel.com>
Date: Mon, 13 Jun 2005 10:48:17 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: quade <quade@hsnr.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: latency error (~2ms) with nanosleep
References: <20050613133047.GA11979@hsnr.de>
In-Reply-To: <20050613133047.GA11979@hsnr.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

quade wrote:
> Playing around with the (simple) measurement of latency-times
> I noticed, that the systemcall "nanosleep" has always a minimal
> latency from about ~2ms (haven't run it all night, so...). It
> seems to be a systematical error.

Known issue.  The x86 interrupt usually has a period of slightly less 
than a ms.  It will therefore generally add nearly a whole ms to ensure 
that it does not ever wait for *less* than specified.

Chris
