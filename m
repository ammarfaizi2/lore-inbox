Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265529AbUAZGcP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 01:32:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265535AbUAZGcP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 01:32:15 -0500
Received: from opersys.com ([64.40.108.71]:21522 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S265529AbUAZGcN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 01:32:13 -0500
Message-ID: <4014B573.1020703@opersys.com>
Date: Mon, 26 Jan 2004 01:36:35 -0500
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Nuno Silva <nuno.silva@vgertech.com>
CC: JustFillBug <mozbugbox@yahoo.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Cooperative Linux
References: <20040125193518.GA32013@callisto.yi.org> <40148C1C.5040102@vgertech.com> <slrnc193vo.42h.mozbugbox@mozbugbox.somehost.org> <4014A058.9080206@vgertech.com>
In-Reply-To: <4014A058.9080206@vgertech.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Nuno Silva wrote:
> That's xen. You can learn more here:
> 
>     http://www.cl.cam.ac.uk/Research/SRG/netos/xen/

For a UP system, Xen may be fine, depending on what you're trying to
do. If you're looking for a better VMware, then Xen is likely to fit
your bill. However, there are a few things to keep in mind when
looking at this sort of stuff. So, for example, Xen assumes that all
OSes are going to use the same devices for I/O: same disk, same
NIC, etc. It therefore implements lots of virtual devices for these.
But what if you wanted each OS to manage separate hardware? Also,
I'm not sure I want my OS instances to have to request memory on
a page basis with the nanokernel/monitor. Wouldn't it be just better
to reuse the existing work on the hotplug hardware (hotplug CPU,
hotplug memory, etc.) to have the kernels get/return hardware
resources to the nanokernel? Also, how generic is the virtualization
solution being examined? I've put some thought into getting a
virtualization architecture which spans UP, SMP, SMP-clusters, and
hard-rt, and wrote that down as a series of papers about Adeos. I
probably don't have the final answer, and there are probably many
things I haven't figured out in the papers I've written on the topic,
but you may want to take a look.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546

