Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264260AbUGCK2T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264260AbUGCK2T (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jul 2004 06:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264479AbUGCK2T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jul 2004 06:28:19 -0400
Received: from aun.it.uu.se ([130.238.12.36]:64249 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S264260AbUGCK2S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jul 2004 06:28:18 -0400
Date: Sat, 3 Jul 2004 12:28:09 +0200 (MEST)
Message-Id: <200407031028.i63AS9W3018392@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: Re: [PATCH][2.6.7-mm5] perfctr low-level documentation
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Jul 2004 15:44:14 -0700, Andrew Morton wrote:
>Mikael Pettersson <mikpe@csd.uu.se> wrote:
>>
>> I'm
>> considering Christoph Hellwig's suggestion of moving
>> the API back to /proc/<pid>/, but with multiple files
>> and open/read/write/mmap instead of ioctl. I believe I
>> can make that work, but it would take a couple of days
>> to implement properly. Please indicate if you would like
>> this change or not.
>
>What would be the advantages of such a change?

Eliminating the 6 or so new syscalls I was forced
to add when nuking the old ioctl() API.

There would be a /proc/<pid>/<tid>/perfctr/ directory
with files representing the control data, counter
state, general info, and auxiliary control ops.

/Mikael
