Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262848AbVGMWS6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262848AbVGMWS6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 18:18:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262799AbVGMWS5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 18:18:57 -0400
Received: from wproxy.gmail.com ([64.233.184.198]:202 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262873AbVGMWR4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 18:17:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FPqT4Vv5EbcCmjri63wjSYFKw+jqoTbvrBV4vG6slwUvjoHsEXLR/TqxF1JEsDFd4okZCe+JlQjRGlWuHrPYqrcepshw0SuyWodlFualFFRjxr5/yl+mmyI0TCLcISxkkdazSWWfUOtUNlG/iZZ7hFxJU5Vw/CKFbCSvVIOF1lE=
Message-ID: <9e4733910507131516522d8e07@mail.gmail.com>
Date: Wed, 13 Jul 2005 18:16:59 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: Bridge changes and lost console on 2.6.13-rc3
Cc: linux-kernel@vger.kernel.org, ink@jurassic.park.msu.ru
In-Reply-To: <20050713140644.16812c32.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9e4733910507130952372a5bd@mail.gmail.com>
	 <20050713140644.16812c32.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/13/05, Andrew Morton <akpm@osdl.org> wrote:
> Can you please do a `dmesg > foo', then compare that with the 2.6.13-rc2
> dmesg output, send us a summary of what changed?

It failed the same way under rc2.  See this thread: "2.6.13-rc2 hangs at boot".
The difference is that now I know in my case it is not a hang, the
system is still there, I just lost the console.

This is the problem patch:
Author: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Date: Wed, 15 Jun 2005 14:59:27 +0000 (+0400)
Source: http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=299de0343c7d18448a69c635378342e9214b14af

 [PATCH] PCI: pci_assign_unassigned_resources() on x86


-- 
Jon Smirl
jonsmirl@gmail.com
