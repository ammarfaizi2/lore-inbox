Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288809AbSATQlE>; Sun, 20 Jan 2002 11:41:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288810AbSATQky>; Sun, 20 Jan 2002 11:40:54 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:29168 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S288809AbSATQkm>; Sun, 20 Jan 2002 11:40:42 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.NEB.4.44.0201201719060.20948-100000@mimas.fachschaften.tu-muenchen.de> 
In-Reply-To: <Pine.NEB.4.44.0201201719060.20948-100000@mimas.fachschaften.tu-muenchen.de> 
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Momchil Velikov <velco@fadata.bg>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] __linux__ and cross-compile 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 20 Jan 2002 16:37:24 +0000
Message-ID: <2960.1011544644@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


bunk@fs.tum.de said:
>  It's clear that code that is part of an "#ifndef __linux__" will
> never be included on any other OS than Linux.

True. But unfortunately that's not a useful guarantee. This code doesn't
(normally) run _on_ Linux. It is _in_ Linux, and it's still possible that
the offending code won't get included when it should.

> Is this also garuanteed for "#ifndef __KERNEL__"? 

We think *BSD uses _KERNEL, and don't know of anything else which defines 
__KERNEL__ other than Linux. So he's switching from something that's known 
broken to something which we _believe_ will be reliable.

--
dwmw2


