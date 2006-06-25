Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965590AbWFYUIE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965590AbWFYUIE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 16:08:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932241AbWFYUIE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 16:08:04 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:35679 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932235AbWFYUIC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 16:08:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=c3lINfYn3Wquco13hQ1U8oe9jbQOzgCIixYi8hQ6gdIHbF4hzRSqMzWxycgyr1xH3uxdR9m3QUJCsdLFwNEZwUw5E58PpH2EjV3cZ/7o53BusdVTfRcJGWwqbx66VphEDhE80dQqgrI/FI6n8QzHD/6rvmxTYG+AMqwdeLsqOMc=
Message-ID: <a44ae5cd0606251308k258eafdfpfc23ca2ad96fc3ad@mail.gmail.com>
Date: Sun, 25 Jun 2006 13:08:01 -0700
From: "Miles Lane" <miles.lane@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: 2.6.17-mm2 -- Slab corruption, plus invalid opcode: 0000 [#1] -- 4K_STACKS PREEMPT -- last sysfs file: /block/md0/dev
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
In-Reply-To: <20060625120026.513a6076.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <a44ae5cd0606241628u18fc9530g9dfbbfca441309fc@mail.gmail.com>
	 <20060624212940.ea8976ae.akpm@osdl.org>
	 <a44ae5cd0606251153j1220f8f5rd5fc6ab85027e3d0@mail.gmail.com>
	 <20060625120026.513a6076.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/25/06, Andrew Morton <akpm@osdl.org> wrote:

> Do you have
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17/2.6.17-mm2/hot-fixes/cpufreq_register_driver-section-fix.patch
> applied?

Great!  That fixed it.  Thanks.

I still have this showing up:

Slab corruption: start=f021ed10, len=1424
030: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 56 9f fb 54
060: 6b 6b 6b 6b 05 00 00 00 6b 6b 6b 6b 6b 6b 6b 6b
Prev obj: start=f021e780, len=1424
000: 02 00 00 00 00 c0 82 f4 02 00 00 00 00 00 40 00
010: 00 00 00 00 ff ff ff ff 80 00 00 00 76 00 00 00
Next obj: start=f021f2a0, len=1424
000: 00 00 00 00 00 50 01 f3 02 00 00 00 40 20 40 00
010: 00 00 00 00 ff ff ff ff 80 00 00 00 75 00 00 00
