Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265938AbUE1IMi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265938AbUE1IMi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 04:12:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265940AbUE1IMi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 04:12:38 -0400
Received: from main.gmane.org ([80.91.224.249]:50584 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S265938AbUE1IMd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 04:12:33 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Subject: Re: Can't make XFS work with 2.6.6
Date: Fri, 28 May 2004 10:12:27 +0200
Message-ID: <yw1xn03t0y38.fsf@kth.se>
References: <200405271736.08288.dj@david-web.co.uk> <200405271854.20787.dj@david-web.co.uk>
 <1085680806.5311.44.camel@buffy> <200405271925.24650.dj@david-web.co.uk>
 <1085695702.10106.65.camel@buffy> <20040528072030.GA24992@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 213-187-164-3.dd.nextgentel.com
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:0KJOVxML2v7XHym8trcWhKQ0x+Q=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> writes:

> On Thu, May 27, 2004 at 06:08:23PM -0400, David Aubin wrote:
>> Hi Dave,
>> 
>>   You do not have devfs enabled.  So root=/dev/hda3
>> should not work.  Please enable in kernel and retry.
>> 
>> # CONFIG_DEVFS_FS is not set
>
> Exactly the wrong way around.  If you're brave enough to use
> devfs you need to use devfs names on the command line.

Not at all.

$ cat /proc/cmdline 
root=/dev/hda1 video=sisfb:mode:1024x768x8
$ gunzip -c /proc/config.gz | grep DEVFS
CONFIG_DEVFS_FS=y
CONFIG_DEVFS_MOUNT=y
# CONFIG_DEVFS_DEBUG is not set

Yes, I should switch to udev, but I don't have time to mess around
with that stuff right now, and the machine works the way it is.

-- 
Måns Rullgård
mru@kth.se

