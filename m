Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161257AbWJKUj2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161257AbWJKUj2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 16:39:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161258AbWJKUj2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 16:39:28 -0400
Received: from terminus.zytor.com ([192.83.249.54]:18874 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1161257AbWJKUj1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 16:39:27 -0400
Message-ID: <452D566A.50705@zytor.com>
Date: Wed, 11 Oct 2006 13:39:06 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Jakub Jelinek <jakub@redhat.com>
CC: Al Viro <viro@ftp.linux.org.uk>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] use %p for pointers
References: <E1GXPU5-0007Ss-HU@ZenIV.linux.org.uk> <Pine.LNX.4.61.0610111316120.26779@yvahk01.tjqt.qr> <20061011145441.GB29920@ftp.linux.org.uk> <452D3BB6.8040200@zytor.com> <20061011202814.GD20982@devserv.devel.redhat.com>
In-Reply-To: <20061011202814.GD20982@devserv.devel.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jakub Jelinek wrote:
> On Wed, Oct 11, 2006 at 11:45:10AM -0700, H. Peter Anvin wrote:
>> Al Viro wrote:
>>> %p will do no such thing in the kernel.  As for the difference...  %x
>>> might happen to work on some architectures (where sizeof(void 
>>> *)==sizeof(int)),
>>> but it's not portable _and_ not right.  %p is proper C for that...
>> It's really too bad gcc bitches about %#p, because that's arguably The 
>> Right Thing.
> 
> It is correct that gcc warns about %#p, that invokes undefined behavior
> in ISO C99.
> 

Yes, it's a bug in the standard.

	-hpa

