Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263310AbUACOLc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 09:11:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263357AbUACOLc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 09:11:32 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:1554 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263310AbUACOLa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 09:11:30 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: The survival of ide-scsi in 2.6.x
Date: Sat, 03 Jan 2004 09:11:35 -0500
Organization: TMR Associates, Inc
Message-ID: <bt6hs5$apq$1@gatekeeper.tmr.com>
References: <20031226181242.GE1277@linnie.riede.org> <3FED7E80.20800@planet.nl> <20031227131724.GG1277@linnie.riede.org> <3FEF4EF2.4080303@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1073138373 11066 192.168.12.10 (3 Jan 2004 13:59:33 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
In-Reply-To: <3FEF4EF2.4080303@planet.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stef van der Made wrote:
> 
> Hi Willem,
> 
> The standard stuff like mt -f /dev/ht0 status etc etc works. But tar 
> doesn't wan't to-do backups anymore both with and witout the patch on a 
> 2.6.0 kernel. I don't have a 2.4.x kernel handy to test if it still 
> works with those kernels and my drive.
> 
> What I've done is the following:
> 
> bash-2.05# tar -cvb 64 -f /dev/ht0 /
> tar: Removing leading `/' from absolute path names in the archive
> 
> lost+found/
> usr/
> usr/X11
> usr/adm
> usr/bin/
> usr/bin/w
> usr/bin/ar
> tar: Cannot write to /dev/ht0: Invalid argument
> tar: Error is not recoverable: exiting now
> 
> It looks as if the backup starts but it almost immediatly ends after the 
> drive does some spinning and reading and or writing.

It sounds stupid, but you did set the tape block size as appropriate, 
didn't you? I've seen similar with incorrect block size writes in the 
past, but I don't have the correct hardware home to try it.

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
