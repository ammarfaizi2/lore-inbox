Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315613AbSECJLM>; Fri, 3 May 2002 05:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315614AbSECJLL>; Fri, 3 May 2002 05:11:11 -0400
Received: from gateway2.ensim.com ([65.164.64.250]:5893 "EHLO
	nasdaq.ms.ensim.com") by vger.kernel.org with ESMTP
	id <S315613AbSECJLK>; Fri, 3 May 2002 05:11:10 -0400
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0
From: Paul Menage <pmenage@ensim.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replace exec_permission_lite() with inlined vfs_permission() 
cc: pmenage@ensim.com
In-Reply-To: Your message of "Fri, 03 May 2002 02:03:47 PDT."
             <E173Yyh-0004zD-00@pmenage-dt.ensim.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 03 May 2002 02:10:55 -0700
Message-Id: <E173Z5b-000502-00@pmenage-dt.ensim.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>- nfs and coda give -EAGAIN if they would need to make an rpc call when 
>dcache_lock is held
>

Actually, coda probably isn't safe with this model - it seems to be 
relying on the BKL in permission().

Paul

