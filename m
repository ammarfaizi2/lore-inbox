Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261515AbUKGCPq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261515AbUKGCPq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 21:15:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261516AbUKGCPq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 21:15:46 -0500
Received: from fw.osdl.org ([65.172.181.6]:2501 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261515AbUKGCPm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 21:15:42 -0500
Date: Sat, 6 Nov 2004 18:15:13 -0800
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: rusty@rustcorp.com.au, kraxel@bytesex.org, linux-kernel@vger.kernel.org,
       video4linux-list@redhat.com
Subject: Re: 2.6.10-rc1-mm3: "bttv card=" breakage
Message-Id: <20041106181513.68be72e4.akpm@osdl.org>
In-Reply-To: <20041107013219.GB1295@stusta.de>
References: <20041105001328.3ba97e08.akpm@osdl.org>
	<20041107013219.GB1295@stusta.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:
>
> On Fri, Nov 05, 2004 at 12:13:28AM -0800, Andrew Morton wrote:
> >...
> > All 465 patches:
> >...
> > remove-module_parm-from-allyesconfig-almost.patch
> >   Remove MODULE_PARM from allyesconfig (almost)
> >...
> 
> Does this patch cause the breakage described in Bugzilla #3707?
> 

Think so.  I've subsequently gone thorugh that patch and removed mention of
those files which still have instances of MODULE_PARM in them.  There's a
lot of stuff changing under its feet and I don't want this patch to break
everyone else's work when it goes in.

