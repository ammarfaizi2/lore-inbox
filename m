Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264956AbTLFFrZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 00:47:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264957AbTLFFrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 00:47:25 -0500
Received: from holomorphy.com ([199.26.172.102]:63701 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264956AbTLFFrY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 00:47:24 -0500
Date: Fri, 5 Dec 2003 21:47:20 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: neel vanan <neelvanan@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Kernel panic...
Message-ID: <20031206054720.GN8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	neel vanan <neelvanan@yahoo.com>, linux-kernel@vger.kernel.org
References: <S263478AbTLEJ0s/20031205092648Z+878@vger.kernel.org> <20031205093435.61652.qmail@web9504.mail.yahoo.com> <20031205141928.GD8039@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031205141928.GD8039@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 05, 2003 at 01:34:35AM -0800, neel vanan wrote:
>>  Mounting root filesystem
>>  mount : erro 6 mounting ext3
>>  pivotroot : pivot_root (/sysroot, /sysroot/initrd)
>> failed:2
>>  umount /initrd/proc failed :2
>>  Mounting devfs on /dev
>>  freeing unused kernel memory : 464k freed
>>  Kernel panic: no init found. Try passing init= option
>> to kernel
>> After then blinking cursor.

On Fri, Dec 05, 2003 at 06:19:28AM -0800, William Lee Irwin III wrote:
> Could you post your .config?

Okay, the first thing to try is removing devfs from the equation if
possible. Your mount is getting back -ENXIO, suggesting whatever device
you're trying to mount doesn't exist according to the kernel. devfs
does device management internally to the kernel, so it's a likely culprit.

It would also be helpful to find the command-line arguments issued to
mount(8) when it's failing, as well as more information about the
contents of your initrd. Can you boot without an initrd?


-- wli
