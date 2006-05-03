Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751389AbWECXRw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751389AbWECXRw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 19:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbWECXRw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 19:17:52 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:24755 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751389AbWECXRv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 19:17:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kN+yEnWU7MppKhSCo6mp84K8EwDXHqmob1tbcaqfg5UuajeeqKGUEOveZnHpbPvRNjp5rl4/dK6qKgHhib3tdfyTzC92VGjQDIitkp3H1Xn8vAmnnoozUCune+vCYbksjZbrK/28NXSJ0XhVt+roEQCo9rsQJXhfU56Vo7uqpSM=
Message-ID: <625fc13d0605031617v44c2b278kbf12e00781f55ae6@mail.gmail.com>
Date: Wed, 3 May 2006 18:17:50 -0500
From: "Josh Boyer" <jwboyer@gmail.com>
To: "Jared Hulbert" <jaredeh@gmail.com>
Subject: Re: [RFC] Advanced XIP File System
Cc: "Jan Engelhardt" <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org
In-Reply-To: <6934efce0605031154l225caee8yc217c6e63c0dd441@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <6934efce0605021453l31a438c4j7c429e6973ab4546@mail.gmail.com>
	 <Pine.LNX.4.61.0605031832230.13546@yvahk01.tjqt.qr>
	 <6934efce0605031154l225caee8yc217c6e63c0dd441@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/3/06, Jared Hulbert <jaredeh@gmail.com> wrote:
>
> We took Familiar Linux 0.8.3 Opie verision and built two versions, one
> that used jffs2 on NAND and another that used XIP cramfs on NOR.  We

Erm, why was one built on NAND and one on NOR?  You're comparing
apples to oranges now.

You're also comparing different price points.  Depending on various
factors, NAND flash can be 3x cheaper than NOR.  But I agree that
economics should be left out of this discussion.  There are people
that want to use XIP, and economics has nothing to do with the
technology that enables that to happen.

> optimized the XIP cramfs to only uncompress commonly used libraries
> and binaries.  The XIP build used 8MiB more flash.  It saved about
> 20MiB of RAM and was 3X faster at bootup.  (Summary support on jffs2
> closed the gap to 2X boot up but made the jffs2 use _more_ flash than
> the XIP).  The jffs2 version volume wouldn't run the PIM apps and the

If the NAND device was a small block device, summary support won't
really help at all there.

> browser and Quake at the same time with only 32MiB of RAM.  The XIP
> version would.  The jffs2 version used 42MiB and the XIP 50MiB.
> Rounding to rational chip sizes that's 32MiB RAM/64MiB Flash versus
> 64MiB RAM/64MiB Flash.

JFFS2 does incur a bit of DRAM overhead.  There are a couple things
kicking around that might help that consumption, but not in the
magnitude you're mentioning here.

josh
