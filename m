Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751965AbWCBD1A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751965AbWCBD1A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 22:27:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751971AbWCBD07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 22:26:59 -0500
Received: from ns1.suse.de ([195.135.220.2]:25760 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751965AbWCBD06 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 22:26:58 -0500
From: Andi Kleen <ak@suse.de>
To: Dave Jones <davej@redhat.com>
Subject: Re: 2.6.16rc5 'found' an extra CPU.
Date: Thu, 2 Mar 2006 04:24:41 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       Ashok Raj <ashok.raj@intel.com>
References: <20060301224647.GD1440@redhat.com> <200603020238.31639.ak@suse.de> <20060302031348.GE19755@redhat.com>
In-Reply-To: <20060302031348.GE19755@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603020424.42500.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 March 2006 04:13, Dave Jones wrote:

> *boggle*, there really are only two single-core CPUs in there,
> with no empty sockets. It's an early stepping of the motherboard
> too that supposedly doesn't support dual-core.  So why these are present
> at all, let alone 'disabled' is a mystery to me.

It's probably for the second cores. Instead of rewriting the tables
dynamically they just change the enable/disable bit.  That's pretty
common actually, often seen on laptops too.

With Quadcores it will get interesting I guess.

If you had to write in 16bit x86 asm you would likely use such
tricks too ;-)
 
> logrotate ate the old logs, so I don't have any old bootlogs
> to grep through, but I'll take your word for it :)
> 
> Why ACPI decides to create 3 processor entries is still odd though.

It should be four.

-Andi
