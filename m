Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261970AbREPOuK>; Wed, 16 May 2001 10:50:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261972AbREPOuA>; Wed, 16 May 2001 10:50:00 -0400
Received: from smtpde02.sap-ag.de ([194.39.131.53]:54692 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S261970AbREPOts>; Wed, 16 May 2001 10:49:48 -0400
From: Christoph Rohland <cr@sap.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rootfs (part 1)
In-Reply-To: <Pine.GSO.4.21.0105160756210.24199-100000@weyl.math.psu.edu>
Organisation: SAP LinuxLab
Date: 16 May 2001 16:43:37 +0200
In-Reply-To: <Pine.GSO.4.21.0105160756210.24199-100000@weyl.math.psu.edu>
Message-ID: <m3wv7h5p7q.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Al,

On Wed, 16 May 2001, Alexander Viro wrote:
> 	One point that might be better done differently - since we
> need ramfs for boot I've just made fs/Config.in declare CONFIG_RAMFS
> as define_bool CONFIG_RAMFS y. If ramfs grows (e.g. gets resource
> limits patches from -ac) we might be better off doing a minimal
> variant permanently in kernel (calling it rootfs) and making
> ramfs use rootfs methods. It's completely separate issue, so I've
> done it the simplest way for the time being.

Why do you use ramfs? Most of it is duplicated in tmpfs and ramfs is a
minimal _example_ fs. There was some agreement that this should stay
so.

Look into mm/shmem.c and look how little is added by CONFIG_TMPFS and
how much is duplicated from ramfs

If we really think the added swap vector per file in tmpfs is a major
overhead we should add the nonswapping functions there.

Greetings
		Christoph


