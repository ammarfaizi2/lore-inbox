Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264110AbTDJRTU (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 13:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264113AbTDJRTU (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 13:19:20 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:36483 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S264110AbTDJRTR (for <rfc822;linux-kernel@vger.kernel.org>); Thu, 10 Apr 2003 13:19:17 -0400
Date: Thu, 10 Apr 2003 18:30:17 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: CaT <cat@zip.com.au>
Cc: linux-kernel@vger.kernel.org, sct@redhat.com, akpm@zip.com.au,
       adilger@clusterfs.com, davem@redhat.com, jmorris@intercode.com.au
Subject: Re: 2.5.67: ext3 and tcp BUG()/oops/error/whatnot?
Message-ID: <20030410173017.GB20177@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	CaT <cat@zip.com.au>, linux-kernel@vger.kernel.org, sct@redhat.com,
	akpm@zip.com.au, adilger@clusterfs.com, davem@redhat.com,
	jmorris@intercode.com.au
References: <20030410163857.GB19129@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030410163857.GB19129@zip.com.au>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 11, 2003 at 02:38:58AM +1000, CaT wrote:

 > Slab corruption: start=ce6130c4, expend=ce6131f3, problemat=ce613128
 > Last user: [<c032ff78>](destroy_conntrack+0x9c/0xac)
 > Data: ****************************************************************************************************28 31 61 CE 28 31 61 CE ***************************************************************************************************************************************************************************************************A5 
 > Next: 71 F0 2C .78 FF 32 C0 71 F0 2C .********************
 > slab error in check_poison_obj(): cache `ip_conntrack': object was modified after freeing
 > Call Trace:
 >  [<c0131d5d>] __slab_error+0x21/0x28
 >  [<c013214c>] check_poison_obj+0x174/0x180
 >  [<c01331b9>] kmem_cache_alloc+0x8d/0x128
 >  [<c033075f>] init_conntrack+0xcf/0x310
 >  [<c033075f>] init_conntrack+0xcf/0x310

Known bug, with known fix. This really should go to Linus.
http://bugzilla.kernel.org/show_bug.cgi?id=497
 
 > buffer layer error at fs/buffer.c:127
 > Call Trace:
 >  [<c0143cea>] __buffer_error+0x2a/0x30
 >  [<c0143de6>] __wait_on_buffer+0x66/0xb0
 >  [<c0119088>] autoremove_wake_function+0x0/0x3c
 >  [<c0119088>] autoremove_wake_function+0x0/0x3c

False alarm caused by buggy debugging code.
See my posting yesterday in the thread about breaking
reiserfs.

		Dave

