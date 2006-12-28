Return-Path: <linux-kernel-owner+w=401wt.eu-S1754879AbWL1PvK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754879AbWL1PvK (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 10:51:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754884AbWL1PvK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 10:51:10 -0500
Received: from il.qumranet.com ([62.219.232.206]:56361 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754879AbWL1PvJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 10:51:09 -0500
Message-ID: <4593E7EB.7070801@argo.co.il>
Date: Thu, 28 Dec 2006 17:51:07 +0200
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Jeff Chua <jeff.chua.linux@gmail.com>
CC: Dor Laor <dor.laor@qumranet.com>, lkml <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
Subject: Re: open /dev/kvm: No such file or directory
References: <b6a2187b0612280508t24e0a740nd1aabdfeb706fbec@mail.gmail.com>	 <64F9B87B6B770947A9F8391472E0321609AB0D35@ehost011-8.exch011.intermedia.net>	 <b6a2187b0612280638o3d7c48ecn13b5dece8395b41a@mail.gmail.com>	 <4593D9F5.6010807@argo.co.il> <b6a2187b0612280742x1b613849ye23aca38c71a5871@mail.gmail.com>
In-Reply-To: <b6a2187b0612280742x1b613849ye23aca38c71a5871@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Chua wrote:
> On 12/28/06, Avi Kivity <avi@argo.co.il> wrote:
>
>> udev is the best solution here.  It works with read-only root as it
>> mounts tmpfs on /dev.
>
> Thanks for the suggestion and I'll look into it. As for now, my system
> works well without udev, and I just wanted to test kvm without the
> "dynamic" /dev/kvm feature if possible.
>
> Would it be possible to create /dev/kvm once and let it stay there
> permanently? How about a switch for non-udev system?

[cc'ing udev guru]

Greg, /dev/kvm is a MISC_DYNAMIC_MINOR device.  Is there any way of 
using it without udev?  Should I allocate a static number?


-- 
error compiling committee.c: too many arguments to function

