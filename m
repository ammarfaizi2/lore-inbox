Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262356AbVEMMto@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262356AbVEMMto (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 08:49:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262357AbVEMMtn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 08:49:43 -0400
Received: from wproxy.gmail.com ([64.233.184.203]:47195 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262356AbVEMMtY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 08:49:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YsIjmA5BWx+ERAxFqTTqcMu2bP29ldS7fth6W+dOhtB8PU3J3nsb84M0nLo6eU/cvNC8hH88QTf71Gv61bFX9wk9FJDFnCCgj5JNu4M/tsG8jnyoy81cKGCcv8Wi8EqHvnKfemHdwIK3C2hRLpiQ/T5B4/U3eUF572MrQgPITLI=
Message-ID: <4de7f8a6050513054938ee6613@mail.gmail.com>
Date: Fri, 13 May 2005 14:49:23 +0200
From: Jan Blunck <jblunck@gmail.com>
Reply-To: Jan Blunck <jblunck@gmail.com>
To: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [ANNOUNCE] mini_fo-0.6.0 overlay file system
Cc: Markus Klotzbuecher <mk@creamnet.de>,
       =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <2F200E69-465D-46ED-9D3A-5ED5C9FEAC9A@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <20050509183135.GB27743@mary>
	 <20050512121842.GA20388@wohnheim.fh-wedel.de>
	 <20050512164413.GA14099@mary>
	 <2F200E69-465D-46ED-9D3A-5ED5C9FEAC9A@mac.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/13/05, Kyle Moffett <mrmacman_g4@mac.com> wrote:
> 
> I've been thinking about a "-o union" mount option for a while now, and
> I had a couple ideas on this topic.
> 

So, I'm not the only one :) Actually, I'm working on a VFS based union
mounts implementation. There are still some major bugs which I want to
fix before posting the patches.

Some key features:
- VFS based approach, all file systems *should* work when mounted read-only
- unification of directory listings with readdir()
- copy-up with the help of Jörn's madcow patches to sendfile
- whiteout implementation for the VFS and ext2

The patches basically implement a union stack with/on dentries. That
is working quite well but I still have some issues with the dcache. At
the moment other stuff has higher priorities.

Jan
