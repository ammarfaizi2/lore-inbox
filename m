Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261916AbVCSWfG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261916AbVCSWfG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 17:35:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261900AbVCSWfG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 17:35:06 -0500
Received: from mail.enyo.de ([212.9.189.167]:47237 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S261916AbVCSWeu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 17:34:50 -0500
From: Florian Weimer <fw@deneb.enyo.de>
To: Bernd Eckenfels <ecki@lina.inka.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [MC] [CHECKER] Do ext2, jfs and reiserfs respect mount -o sync/dirsync option?
References: <E1D8SdK-0003B4-00@calista.eckenfels.6bone.ka-ip.net>
Date: Sat, 19 Mar 2005 23:34:47 +0100
In-Reply-To: <E1D8SdK-0003B4-00@calista.eckenfels.6bone.ka-ip.net> (Bernd
	Eckenfels's message of "Tue, 08 Mar 2005 01:31:34 +0100")
Message-ID: <87k6o39se0.fsf@deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Bernd Eckenfels:

> In article <Pine.GSO.4.44.0503041440030.17155-100000@elaine24.Stanford.EDU> you wrote:
>> 3. I open a file w/o O_SYNC, issue a bunch of writes, then call
>> ioctl(FIOASYNC) to set the fd sync, then issure a second set of writes.
>> Only the second set of writes are synchronous?
>
> I also am curious if one can open a file, write to it, close it, open it and
> do fsync()/fdatasync() on it?

Hopefully the fsync/fdatasync call will flush all previous writes
(even from other processes).  Berkeley DB relies on this behavior for
correct operation.
