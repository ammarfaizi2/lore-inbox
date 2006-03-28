Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932466AbWC1Wee@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932466AbWC1Wee (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 17:34:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932457AbWC1Wee
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 17:34:34 -0500
Received: from smtp.osdl.org ([65.172.181.4]:16312 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932434AbWC1Wed (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 17:34:33 -0500
Date: Tue, 28 Mar 2006 14:34:29 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Trond Myklebust <Trond.Myklebust@netapp.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linux Filesystem Development <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] config: Fix CONFIG_LFS option
In-Reply-To: <1143584319.8199.34.camel@lade.trondhjem.org>
Message-ID: <Pine.LNX.4.64.0603281430370.15714@g5.osdl.org>
References: <1143584319.8199.34.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 28 Mar 2006, Trond Myklebust wrote:
>
> The help text says that if you select CONFIG_LBD, then it will
> automatically select CONFIG_LFS. Nope... That isn't currently the
> case.

I'm not sure your patch makes anything much better, though.

Why does CONFIG_LSF exist in the first place? Afaik, it only affects a 
totally not-very-interesting thing (blkcnt_t) for a totally not very 
interesting feature (the number of people who want single files >2TB is 
likely not very big).

Having it auto-selected by LBD sounds insane, since LBD is likely more 
interesting than LSF itsef is. It would make more sense to go the other 
way (have LSF auto-select LBD).

			Linus
