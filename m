Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262051AbTHTRB4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 13:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262068AbTHTRBp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 13:01:45 -0400
Received: from main.gmane.org ([80.91.224.249]:50653 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262051AbTHTRAJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 13:00:09 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: how to turn off, or to clear read cache?
Date: Wed, 20 Aug 2003 18:57:15 +0200
Message-ID: <yw1xptj0b72s.fsf@users.sourceforge.net>
References: <200308201322.h7KDMQga000797@81-2-122-30.bradfords.org.uk> <3F437646.4050107@gamic.com>
 <yw1x8ypocv63.fsf@users.sourceforge.net>
 <20030820164949.GA5613@lsd.di.uminho.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:HZREoTZDqOXGARKik0xFyltByow=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luciano Miguel Ferreira Rocha <luciano@lsd.di.uminho.pt> writes:

>> >>> I need to make some performance tests. I need to switch off or to
>> >>> clear read cache, so that consequent reading of the same file will
>> >>> take the same amount of time.
>> >>>
>> >>>Is there an easy way to do it, without rebuilding the kernel?
>> >> Unmount and remount the filesystem.
>> >
>> >
>> > Would
>> >
>> > # mount -o remount
>> >
>> > do the job?
>> 
>> no
>
> What about dd if=/dev/hda bs=8M count=$(awk '/MemTotal/ { printf "%d", $2/4096 }' /proc/meminfo) ?
>
> Will it clear the cache?

It will probably clear some cache to make room for cache from hda.

perl -e '@f[0..100000000]=0'

will do it faster.

-- 
Måns Rullgård
mru@users.sf.net

