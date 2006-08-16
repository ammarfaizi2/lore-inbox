Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750936AbWHPHWV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750936AbWHPHWV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 03:22:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750965AbWHPHWV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 03:22:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:56994 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750936AbWHPHWV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 03:22:21 -0400
Date: Wed, 16 Aug 2006 09:22:18 +0200
From: Andi Kleen <ak@muc.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [2/3] Create call_usermodehelper_pipe()
Message-Id: <20060816092218.4ee23eb8.ak@muc.de>
In-Reply-To: <20060815191319.e535f5c6.akpm@osdl.org>
References: <20060814 127.183332000@suse.de>
	<20060814112731.5A16213BD9@wotan.suse.de>
	<20060815142225.52cc86b3.akpm@osdl.org>
	<20060815191319.e535f5c6.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 current->files=&init_files.
> 
> hm, that's wrong, isn't it - we're not using CLONE_FILES...

Yes, I thought I got that right but you shocked me quickly :)

> 
> So what we have is a copy of init_files.  So the sys_close(0) shouldn't be needed?

Probably not. It was just paranoia I guess.

-Andi
