Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313443AbSDLIK1>; Fri, 12 Apr 2002 04:10:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313444AbSDLIK0>; Fri, 12 Apr 2002 04:10:26 -0400
Received: from sv1.valinux.co.jp ([202.221.173.100]:52750 "HELO
	sv1.valinux.co.jp") by vger.kernel.org with SMTP id <S313443AbSDLIKW>;
	Fri, 12 Apr 2002 04:10:22 -0400
Date: Fri, 12 Apr 2002 17:10:12 +0900 (JST)
Message-Id: <20020412.171012.10906743.taka@valinux.co.jp>
To: bcrl@redhat.com
Cc: davem@redhat.com, ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zerocopy NFS updated
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <20020411133307.B20895@redhat.com>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for your suggestion.

bcrl> One possibility is to make the inode semaphore a rwsem, and to have NFS 
bcrl> take that for read until the sendpage is complete.  The idea of splitting 
bcrl> the inode semaphore up into two (one rw against truncate) has been bounced 
bcrl> around for a few other reasons (like allowing multiple concurrent reads + 
bcrl> writes to a file).  Perhaps its time to bite the bullet and do it.

It sounds not so bad.
Partial truncating would rarely happens, so it might be enough.
I'll give it a try.

Regards,
Hirokazu Takahashi
