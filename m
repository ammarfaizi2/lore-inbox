Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263224AbTDMEUX (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 00:20:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263239AbTDMEUX (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 00:20:23 -0400
Received: from [12.47.58.73] ([12.47.58.73]:62863 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S263224AbTDMEUX (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Apr 2003 00:20:23 -0400
Date: Sat, 12 Apr 2003 21:32:05 -0700
From: Andrew Morton <akpm@digeo.com>
To: Jeremy Hall <jhall@maoz.com>
Cc: jhall@maoz.com, felipe_alfaro@linuxmail.org, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.5.67-mm2
Message-Id: <20030412213205.4bcbe1d8.akpm@digeo.com>
In-Reply-To: <200304130422.h3D4M6XY031187@sith.maoz.com>
References: <200304130354.h3D3slbp031124@sith.maoz.com>
	<200304130422.h3D4M6XY031187@sith.maoz.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Apr 2003 04:32:04.0633 (UTC) FILETIME=[A28B1090:01C30175]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Hall <jhall@maoz.com> wrote:
>
> ah, here we go
> 
> BUG(); line 907 of mm/slab.c
> 

Yup, it looks like the lockmeter patch has borked the preempt_count when
CONFIG_LOCKMETER=n.  Sorry, I didn't test it with preempt enabled.

I'll fix that up.  Meanwhile you can revert the lockmeter patch or disable
preemption.

