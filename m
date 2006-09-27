Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030649AbWI0TLM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030649AbWI0TLM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 15:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030651AbWI0TLM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 15:11:12 -0400
Received: from hera.kernel.org ([140.211.167.34]:20442 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1030649AbWI0TLL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 15:11:11 -0400
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: Zero copy between ISR, kernel and User
Date: Wed, 27 Sep 2006 12:10:30 -0700
Organization: OSDL
Message-ID: <20060927121030.4469ec6e@freekitty>
References: <4519F7A9.4050807@saville.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1159384240 9926 10.8.0.54 (27 Sep 2006 19:10:40 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Wed, 27 Sep 2006 19:10:40 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.3; i486-pc-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Sep 2006 21:01:45 -0700
Wink Saville <wink@saville.com> wrote:

> Hello,
> 
> I would like to allow the transferring of data between ISR's, kernel and 
> user code, without requiring copying. I envision allocating buffers in 
> the kernel and then mapping them so that they appear at the same 
> addresses to all code, and never being swapped out of memory.
> 
> Is this feasible for all supported Linux architectures and is there 
> existing code that someone could point me towards?
> 
> Regards,
> 
> Wink Saville
> 

Your better off having application mmap a device, then transfer
the data to there. Something like AF_PACKET.

-- 
Stephen Hemminger <shemminger@osdl.org>
