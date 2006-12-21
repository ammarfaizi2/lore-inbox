Return-Path: <linux-kernel-owner+w=401wt.eu-S1161161AbWLUCwN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161161AbWLUCwN (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 21:52:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161163AbWLUCwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 21:52:13 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:7733 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161161AbWLUCwM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 21:52:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=MriH0/wdcr2ULOfvrucQhsCV2cRu+oWBm0aMXTdOJESz8hvYaBmW+RLVo+iyoz2H/LBM7bdcg3LRz1yrp+WM3wRlZeIth/Cz2D7Uq4ILWc7FqjHetM5uiy08zb+Z7JXZtYkpDiXbjpsjQgayvsQukK3rjS6VdremoNVGM0/A2Eo=
Message-ID: <787b0d920612201852u62bb43ebs82d9129a849b0e50@mail.gmail.com>
Date: Wed, 20 Dec 2006 21:52:09 -0500
From: "Albert Cahalan" <acahalan@gmail.com>
To: junkio@cox.net, merlyn@stonehenge.com, git@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [BUG] daemon.c blows up on OSX
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:

> So it would appear that for OS X, the
>
>       #define _XOPEN_SOURCE_EXTENDED 1 /* AIX 5.3L needs this */
>       #define _GNU_SOURCE
>       #define _BSD_SOURCE
> sequence actually _disables_ those things.

Yes, of course. The odd one here is glibc.

Normal systems enable everything by default. As soon as you
specify a feature define, you get ONLY what you asked for.
I'm not sure why glibc is broken, but I suspect that somebody
wants to make everyone declare their code to be GNU source.
(despite many "GNU" things not working on the HURD at all)

Define _APPLE_C_SOURCE to make MacOS X give you everything.
