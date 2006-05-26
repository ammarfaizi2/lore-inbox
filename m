Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030214AbWEZElm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030214AbWEZElm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 00:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030412AbWEZElm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 00:41:42 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:35598 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1030214AbWEZElm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 00:41:42 -0400
Date: Fri, 26 May 2006 06:32:39 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Stephen Clark <Stephen.Clark@seclark.us>
Cc: Steve Clark <sclark@netwolves.com>, Steve Clark <sclark@dev.netwolves.com>,
       linux-kernel@vger.kernel.org,
       uClinux development list <uclinux-dev@uclinux.org>
Subject: Re: uclinux 2.4.32 panic
Message-ID: <20060526043239.GA12784@w.ods.org>
References: <44746064.30607@netwolves.com> <20060524201030.GU11191@w.ods.org> <4474CF11.4090007@netwolves.com> <20060525063414.GA249@w.ods.org> <4475BB05.6050001@netwolves.com> <447642F6.5030807@seclark.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <447642F6.5030807@seclark.us>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2006 at 07:51:18PM -0400, Stephen Clark wrote:
> Thanks Willy,
> 
> I tracked down the problem it was in the receive_chars(). Whoever did 
> this had an #if 0
> that removed the test of the flip buffer count exceeding the flip buffer 
> size, so under
> stress the buffer would overflow and zero the pointer stored in 
> driver_data field.

Fine. Once your code works OK after the various cleanups, be sure to
send the patches back to the uclinux maintainers (including the fixes
for the rs_write() code we talked about in the first mail).

> Steve

Regards,
Willy

