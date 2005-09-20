Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932779AbVITRob@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932779AbVITRob (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 13:44:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932781AbVITRob
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 13:44:31 -0400
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:54429 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S932779AbVITRoa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 13:44:30 -0400
Date: Tue, 20 Sep 2005 19:44:28 +0200
From: Luca <kronos@kronoz.cjb.net>
To: linux-kernel@vger.kernel.org
Cc: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: 2.6.14-rc1 - kernel BUG at fs/ntfs/aops.c:403
Message-ID: <20050920174428.GA16327@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1127122747.493.5.camel@imp.csi.cam.ac.uk>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov <aia21@cam.ac.uk> ha scritto:
> Hi,
> 
> On Sat, 2005-09-17 at 16:51 +0200, Luca wrote:
>> Jean Delvare <khali@linux-fr.org> ha scritto:
>> > Hi Anton, Bas, all,
>> > 
>> > [Bas Vermeulen]
>> >> > I get a kernel BUG when mounting my (dirty) NTFS volume.
>> >> > 
>> >> > Sep 12 18:54:47 laptop kernel: [4294708.961000] NTFS volume version
>> >> > 3.1. Sep 12 18:54:47 laptop kernel: [4294708.961000] NTFS-fs error
>> >> > (device sda2): load_system_files(): Volume is dirty.  Mounting
>> >> > read-only.  Run chkdsk and mount in Windows.
>> >> > Sep 12 18:54:47 laptop kernel: [4294709.063000] ------------[ cut
>> >> > here ]------------
>> >> > Sep 12 18:54:47 laptop kernel: [4294709.063000] kernel BUG at
>> >> > fs/ntfs/aops.c:403!
>> >
>> > I just hit the same BUG in different conditions. My NTFS volume is not
>> > dirty, not compressed and the BUG triggered on use (updatedb), not
>> > mount.
>> 
>> Same here, but it only triggers accessing a compressed directory. I can
>> reproduce at will just by using 'ls' inside a compressed dir.
> 
> Below is the fix I just sent off to Linus.

Hi Anton,
I can confirm that the patch fixes the bug.

thanks,
Luca
-- 
Home: http://kronoz.cjb.net
"It is more complicated than you think"
                -- The Eighth Networking Truth from RFC 1925
