Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264748AbTANRUM>; Tue, 14 Jan 2003 12:20:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264818AbTANRUM>; Tue, 14 Jan 2003 12:20:12 -0500
Received: from userel174.dsl.pipex.com ([62.188.199.174]:8067 "EHLO
	einstein31.homenet") by vger.kernel.org with ESMTP
	id <S264748AbTANRUL>; Tue, 14 Jan 2003 12:20:11 -0500
Date: Tue, 14 Jan 2003 17:29:58 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
X-X-Sender: <tigran@einstein31.homenet>
To: Arjan van de Ven <arjanv@redhat.com>
cc: Christoph Hellwig <hch@lst.de>, Hugh Dickins <hugh@veritas.com>,
       <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] don't create regular files in devfs (fwd)
In-Reply-To: <1042563017.1401.2.camel@laptop.fenrus.com>
Message-ID: <Pine.LNX.4.33.0301141726280.1241-100000@einstein31.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 Jan 2003, Arjan van de Ven wrote:

> On Tue, 2003-01-14 at 17:32, Tigran Aivazian wrote:
>
> > If you move it all the way to sysfs (i.e. no device node in /dev) then it
> > seems a bit odd that a device driver entry point is found somewhere other
> > than the usual /dev.
>
> well
>
> cat firmware > /sys/processor/0/microcode
>
> is obviously the ultimate interface for this ;)

No, because cat is using 4K chunks and the data has to be written in one
large chunk, like this:

# dd if=microcode of=/dev/cpu/microcode bs=141312 count=1

This actually works fine but you need to convert microcode data from human
readable (what Intel distribute) to binary format first. Easily done with
microcode_ctl utility.

Regards
Tigran

