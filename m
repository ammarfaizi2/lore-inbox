Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750974AbVIQO4m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750974AbVIQO4m (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 10:56:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751039AbVIQO4m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 10:56:42 -0400
Received: from apollo2.tiscali.it.33.205.213.in-addr.arpa ([213.205.33.82]:13541
	"EHLO cp3a.criticalpath.priv") by vger.kernel.org with ESMTP
	id S1750973AbVIQO4m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 10:56:42 -0400
Date: Sat, 17 Sep 2005 16:51:50 +0200
From: Luca <kronos@kronoz.cjb.net>
To: linux-kernel@vger.kernel.org
Cc: Jean Delvare <khali@linux-fr.org>, Anton Altaparmakov <aia21@cam.ac.uk>,
       Bas Vermeulen <bvermeul@blackstar.nl>
Subject: Re: 2.6.14-rc1 - kernel BUG at fs/ntfs/aops.c:403
Message-ID: <20050917145150.GA5481@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050917114459.647654d4.khali@linux-fr.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Delvare <khali@linux-fr.org> ha scritto:
> Hi Anton, Bas, all,
> 
> [Bas Vermeulen]
>> > I get a kernel BUG when mounting my (dirty) NTFS volume.
>> > 
>> > Sep 12 18:54:47 laptop kernel: [4294708.961000] NTFS volume version
>> > 3.1. Sep 12 18:54:47 laptop kernel: [4294708.961000] NTFS-fs error
>> > (device sda2): load_system_files(): Volume is dirty.  Mounting
>> > read-only.  Run chkdsk and mount in Windows.
>> > Sep 12 18:54:47 laptop kernel: [4294709.063000] ------------[ cut
>> > here ]------------
>> > Sep 12 18:54:47 laptop kernel: [4294709.063000] kernel BUG at
>> > fs/ntfs/aops.c:403!
>
> I just hit the same BUG in different conditions. My NTFS volume is not
> dirty, not compressed and the BUG triggered on use (updatedb), not
> mount.

Same here, but it only triggers accessing a compressed directory. I can
reproduce at will just by using 'ls' inside a compressed dir.

> (BTW, is there a way to tell from Linux directly?)

ntfsinfo(8)

Luca
-- 
Home: http://kronoz.cjb.net
Se non puoi convincerli, confondili.
