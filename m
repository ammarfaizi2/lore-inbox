Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280759AbRKKAj5>; Sat, 10 Nov 2001 19:39:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280760AbRKKAjs>; Sat, 10 Nov 2001 19:39:48 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:43555 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S280759AbRKKAji>; Sat, 10 Nov 2001 19:39:38 -0500
Date: Sat, 10 Nov 2001 19:39:36 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFT] final cur of tr based current for -ac8
Message-ID: <20011110193936.H17437@redhat.com>
In-Reply-To: <20011110173331.F17437@redhat.com> <23114.1005432888@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <23114.1005432888@ocs3.intra.ocs.com.au>; from kaos@ocs.com.au on Sun, Nov 11, 2001 at 09:54:48AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2001 at 09:54:48AM +1100, Keith Owens wrote:
> I am still unhappy with that NMI code.  The NMI handler can use generic
> code including printk, the generic code will use the standard
> get_current.  Why does nmi.c not do set_current(hard_get_current());

It can in the current version, but that's generally wrong.  The current 
dependancy is that hard_get_current() only really needs to be used during 
early boot before the TR register is set.  Once that's done, the code can 
use smp_processor_id() anywhere.

		-ben
-- 
Fish.
