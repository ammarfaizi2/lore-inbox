Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268762AbUJKK3n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268762AbUJKK3n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 06:29:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268765AbUJKK3n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 06:29:43 -0400
Received: from smtp.sys.beep.pl ([195.245.198.13]:60941 "EHLO smtp.sys.beep.pl")
	by vger.kernel.org with ESMTP id S268762AbUJKK3k convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 06:29:40 -0400
From: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Organization: SelfOrganizing
To: linux-kernel@vger.kernel.org
Subject: Re: udev: what's up with old /dev ?
Date: Mon, 11 Oct 2004 12:29:01 +0200
User-Agent: KMail/1.7.1
References: <200410102315.i9ANF7OI019460@hacksaw.org> <047CCB21-1B66-11D9-96AD-000D9352858E@linuxmail.org>
In-Reply-To: <047CCB21-1B66-11D9-96AD-000D9352858E@linuxmail.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200410111229.02054.arekm@pld-linux.org>
X-Authenticated-Id: arekm 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 11 of October 2004 11:14, Felipe Alfaro Solana wrote:
> On Oct 11, 2004, at 01:15, Hacksaw wrote:
> >> The very first thing init does is open /dev/console, and if it doesn't
> >> exist the entire boot hangs.
> >
> > This raises a question: Would it be a useful thing to make a modified
> > init
> > that could run udev before it does anything else?
>
> FC3t2 boots from an "initrd" image that, among other things, mounts a
> tmpfs over "/dev" and creates "console", "null", "pts" and then
> proceeds to load "init".
... and it ignores root= kernel cmdline option. rootfs is hardcoded in initrd 
which is very ugly.

Creating /dev entries on rootfs from initrd without hardcoding rootfs device 
is quite problematic.
-- 
Arkadiusz Mi¶kiewicz                    PLD/Linux Team
http://www.t17.ds.pwr.wroc.pl/~misiek/  http://ftp.pld-linux.org/
