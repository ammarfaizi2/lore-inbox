Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751036AbWFUEVy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751036AbWFUEVy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 00:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751979AbWFUEVy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 00:21:54 -0400
Received: from terminus.zytor.com ([192.83.249.54]:1711 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751036AbWFUEVy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 00:21:54 -0400
Message-ID: <4498C95A.3090909@zytor.com>
Date: Tue, 20 Jun 2006 21:21:46 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Masatake YAMATO <jet@gyve.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [patch] sharing maximum errno symbol used in __syscall_return
 (i386)
References: <20060620.184010.225581173.jet@gyve.org>
In-Reply-To: <20060620.184010.225581173.jet@gyve.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Masatake YAMATO wrote:
> Hi,
> 
> __syscall_return in unistd.h is maintained?
> 
> In the macro the value returned from system call is
> compared with the maximum error number defined in a header file 
> to know the call is successful or not. However, the maximum error number 
> is hard-coded and is not updated.
> 

And it's wrong, anyway.  It has long been agreed that the maximum errno 
value, for any architecture, is 4095.

	-hpa
