Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267678AbUJOX6L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267678AbUJOX6L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 19:58:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267793AbUJOX6L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 19:58:11 -0400
Received: from rproxy.gmail.com ([64.233.170.194]:48935 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267678AbUJOX6I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 19:58:08 -0400
DomainKey-Signature: a=rsa-sha1; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=IFqwU1ypl870vzcBHSp4NSoTb74S4XMob13dEPajSsUBuRVlL9In3MIBkyx91Dkph8C1yFJAFykU8I9L9sOhFbWXLWRInkwcprYMYgkPYRV47hNqRUuvpuTHawf8rlHOR2V1jzPMTyhFqYohvZObM/TpO0V9LKnw7kIeW15vawA
Message-ID: <9e47339104101516585e590a6d@mail.gmail.com>
Date: Fri, 15 Oct 2004 19:58:07 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Kendall Bennett <kendallb@scitechsoft.com>
Subject: Re: [Linux-fbdev-devel] Generic VESA framebuffer driver and Video card BOOT?
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
In-Reply-To: <416FFFFD.28877.2F2B6C9@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200410160551.40635.adaplas@hotpop.com>
	 <9e47339104101516206c8597d3@mail.gmail.com>
	 <416FFFFD.28877.2F2B6C9@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Oct 2004 16:51:09 -0700, Kendall Bennett
<kendallb@scitechsoft.com> wrote:
> I have not used initramfs at all (I am not sure I know what it is
> actually) so I don't know. I know there is quite a long period of time on
> most machines from when the kernel starts booting and when the real file
> system based init process takes over.

initramfs/initrd comes up very early in the boot process. For example
it holds your supplemental device drivers and initial /dev.
/dev/console is opened from this /dev so it much be up before the
console is. This is much earlier than normal user space starts.

I believe the current Fedora 3 uses udev from initramfs, but I haven't
tried it yet.

-- 
Jon Smirl
jonsmirl@gmail.com
