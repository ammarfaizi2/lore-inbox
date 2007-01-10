Return-Path: <linux-kernel-owner+w=401wt.eu-S964939AbXAJQx5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964939AbXAJQx5 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 11:53:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964941AbXAJQx4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 11:53:56 -0500
Received: from dvhart.com ([64.146.134.43]:39473 "EHLO dvhart.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964939AbXAJQx4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 11:53:56 -0500
Message-ID: <45A519C8.5000407@mbligh.org>
Date: Wed, 10 Jan 2007 08:52:24 -0800
From: "Martin J. Bligh" <mbligh@mbligh.org>
User-Agent: Thunderbird 1.5.0.9 (X11/20070104)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Jean Delvare <khali@linux-fr.org>,
       Andrey Borzenkov <arvidjaar@mail.ru>, linux-kernel@vger.kernel.org,
       Andy Whitcroft <apw@shadowen.org>,
       Herbert Poetzl <herbert@13thfloor.at>, Olaf Hering <olaf@aepfle.de>
Subject: Re: .version keeps being updated
References: <20070109102057.c684cc78.khali@linux-fr.org>	<20070109170550.AFEF460C343@tzec.mtu.ru>	<20070109214421.281ff564.khali@linux-fr.org>	<20070109133121.194f3261.akpm@osdl.org>	<Pine.LNX.4.64.0701091520280.3594@woody.osdl.org> <20070109152534.ebfa5aa8.akpm@osdl.org>
In-Reply-To: <20070109152534.ebfa5aa8.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Tue, 9 Jan 2007 15:21:51 -0800 (PST)
> Linus Torvalds <torvalds@osdl.org> wrote:
> 
>>
>> On Tue, 9 Jan 2007, Andrew Morton wrote:
>>>> This new behavior of the kernel build system is likely to
>>>> make developers angry pretty quickly.
>>> That might motivate them to fix it ;)
>> Actually, how about just removing the incrementing version count entirely?
> 
> I use it pretty commonly to answer the question "did I remember to install
> that new kernel I just built before I rebooted"?  By comparing `uname -a'
> with $TOPDIR/.version.

Yup, we need to do the same thing in automated testing. Especially when
you're doing lilo -R, and don't know if you ended up fscking or panicing
during attempted reboot to new kernel.

Better would be a checksum of the vmlinux vs the running kernel text,
but that seems to be impossible due to code rewriting. Could we embed
a checksum in a little /proc file for this?

M.
