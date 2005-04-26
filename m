Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261831AbVDZWvE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261831AbVDZWvE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 18:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261808AbVDZWvD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 18:51:03 -0400
Received: from terminus.zytor.com ([209.128.68.124]:34447 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261830AbVDZWu5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 18:50:57 -0400
Message-ID: <426EC5A4.2090107@zytor.com>
Date: Tue, 26 Apr 2005 15:50:12 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Andrew Morton <akpm@osdl.org>, Magnus Damm <magnus.damm@gmail.com>,
       mason@suse.com, mike.taht@timesys.com, mpm@selenic.com,
       linux-kernel@vger.kernel.org, git@vger.kernel.org
Subject: Re: Mercurial 0.3 vs git benchmarks
References: <20050426004111.GI21897@waste.org> <200504260713.26020.mason@suse.com> <aec7e5c305042608095731d571@mail.gmail.com> <200504261138.46339.mason@suse.com> <aec7e5c305042609231a5d3f0@mail.gmail.com> <20050426135606.7b21a2e2.akpm@osdl.org> <Pine.LNX.4.58.0504261405050.18901@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504261405050.18901@ppc970.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Tue, 26 Apr 2005, Andrew Morton wrote:
> 
>>Mounting as ext2 is a useful technique for determining whether the fs is
>>getting in the way.
> 
> 
> What's the preferred way to try to convert a root filesystem to a bigger
> journal? Forcing "rootfstype=ext2" at boot and boot into single-user, and
> then the appropriate magic tune2fs? Or what?
> 

Boot single-user, "remount -o ro,remount /", "tune2fs -J size=xxxM" and 
reboot.

	-hpa
