Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131603AbRCXHgW>; Sat, 24 Mar 2001 02:36:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131604AbRCXHgN>; Sat, 24 Mar 2001 02:36:13 -0500
Received: from [24.112.113.88] ([24.112.113.88]:7924 "EHLO whiskey.enposte.net")
	by vger.kernel.org with ESMTP id <S131603AbRCXHf7>;
	Sat, 24 Mar 2001 02:35:59 -0500
To: linux-kernel@vger.kernel.org
Path: whiskey.fireplug.net!not-for-mail
From: sl@whiskey.fireplug.net (Stuart Lynne)
Newsgroups: list.linux-kernel
Subject: Re: /linuxrc query
Date: 23 Mar 2001 23:33:00 -0800
Organization: fireplug
Distribution: local
Message-ID: <99hijc$8p5$1@whiskey.enposte.net>
In-Reply-To: <985356959.24859@whiskey.enposte.net>
Reply-To: sl@fireplug.net
X-Newsreader: trn 4.0-test67 (15 July 1998)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <985356959.24859@whiskey.enposte.net>,
David Woodhouse <dwmw2@infradead.org> wrote:
>amit@muppetlabs.com said:
>>  Also as a note, what we are doing is keeping our rootfs on flash as a
>> tar.gz and  reading it and mounting it on a ramfs in the /linuxrc
>> before doing a pivot_root.  To summarize, pivot_root has been a life
>> saver as the earlier real_root_dev  might not have been useful in this
>> case. Not using the ramfs limits for now, will do soon.
>
>If you're concerned about memory usage - why untar the whole of your root
>filesystem into a ramfs? My preferred solution is to just mount the root
>filesystem directly from the flash as cramfs (or JFFS2), with symlinks into a
>ramfs for appropriate parts like /tmp and /var.
>
>I suppose the best option is actually to union-mount the ramfs over the 
>root, rather than mucking about with symlinks. I just haven't got round to 
>doing that yet.

Union would be fine. But until then I prefer ramfs as root with symlinks
to cramfs for anything that doesn't need to be writeable. 

-- 
                                            __O 
Lineo - For Embedded Linux Solutions      _-\<,_ 
PGP Fingerprint: 28 E2 A0 15 99 62 9A 00 (_)/ (_) 88 EC A3 EE 2D 1C 15 68
Stuart Lynne <sl@fireplug.net>       www.fireplug.net        604-461-7532
