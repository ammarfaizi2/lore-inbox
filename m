Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286959AbSCKSfQ>; Mon, 11 Mar 2002 13:35:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285424AbSCKSe6>; Mon, 11 Mar 2002 13:34:58 -0500
Received: from smtp2.vol.cz ([195.250.128.42]:5647 "EHLO smtp2.vol.cz")
	by vger.kernel.org with ESMTP id <S286521AbSCKSer>;
	Mon, 11 Mar 2002 13:34:47 -0500
Date: Sun, 10 Mar 2002 23:19:26 +0100
From: Pavel Machek <pavel@Elf.ucw.cz>
To: Stephen Lord <lord@sgi.com>
Cc: svetljo <galia@st-peter.stw.uni-erlangen.de>, linux-kernel@vger.kernel.org,
        linux-xfs@oss.sgi.com
Subject: Re: 2.4.18-rc4-aa1 XFS oopses caused by cpio
Message-ID: <20020310231926.A2354@elf.ucw.cz>
In-Reply-To: <1015580766.20800.3.camel@svetljo.st-peter.stw.uni-erlangen.de> <3C88B612.1070206@sgi.com> <3C88C9A1.5070502@st-peter.stw.uni-erlangen.de> <3C88CB1C.90203@sgi.com> <3C88DFC9.8060907@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C88DFC9.8060907@sgi.com>
User-Agent: Mutt/1.3.23i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >Ah, so you ran growfs on the filesystem, thats the key here. It looks 
> >like the new code
> >does not handle growfs correctly, the structure which is null is not 
> >allocated in the
> >expansion case. I should have a fix shortly.
> >
> >Steve
> 
> Hi,
> 
> Can you try and repeat with this patch, it should apply reasonably 
> cleanly to the aa tree.

Please please, diff -u ...
									Pavel
> 
> ===========================================================================
> Index: linux/fs/xfs/xfs_alloc.c
> ===========================================================================
> 
> 2234a2235,2236
> > 		pag->pagb_list = kmem_zalloc(XFS_PAGB_NUM_SLOTS *
> > 					sizeof(xfs_perag_busy_t), KM_SLEEP);
> 

-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
