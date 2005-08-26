Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965063AbVHZOwx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965063AbVHZOwx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 10:52:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965064AbVHZOwx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 10:52:53 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:4737 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S965063AbVHZOwx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 10:52:53 -0400
Subject: Re: syscall: sys_promote
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Coywolf Qi Hunt <qiyong@fc-cn.com>
Cc: linux-kernel@vger.kernel.org, dhommel@gmail.com
In-Reply-To: <20050826110226.GA5184@localhost.localdomain>
References: <20050826092537.GA3416@localhost.localdomain>
	 <20050826110226.GA5184@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 26 Aug 2005 16:19:17 +0100
Message-Id: <1125069558.4958.83.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-08-26 at 19:02 +0800, Coywolf Qi Hunt wrote:
> > 3) admins can `promote' a suspect process instead of killing it.
> > 
> > Is it also generally useful in practice?  Thoughts?

The locking is wrong. At the moment the entire kernel assumes that a
process uid is not changed by anyone else. After you've implemented uid
locking/refcounting for tasks you can add the syscall but until then its
not a good idea. I don't think its a good idea anyway - selinux can do
far more useful things.


