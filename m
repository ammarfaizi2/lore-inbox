Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262045AbVCLXPL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262045AbVCLXPL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 18:15:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262052AbVCLXPL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 18:15:11 -0500
Received: from zeus.kernel.org ([204.152.189.113]:16054 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262045AbVCLXPF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 18:15:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=qh078KB9Makz8tRBXVcVQqd/bs96/hy3fhc4G2EKbuRbVzz5zFxnrn+Sx2sHbDfIzsPev6GDyP05N200iGl5/ZR7WUROAqhJGGm52yQ8pvVA8768ffIxOSUlfq9GC+UXBMx8QSPPhgISMk6Hrjpa2jK7xdldiGo+K5kwb7aIwPk=
Message-ID: <21d7e9970503121513113ecb81@mail.gmail.com>
Date: Sun, 13 Mar 2005 10:13:49 +1100
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Andrew Morton <akpm@osdl.org>, Dave Airlie <airlied@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: DRI breakage, 2.6.11-mm[123]
In-Reply-To: <6uu0ng7je7.fsf@zork.zork.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050312034222.12a264c4.akpm@osdl.org>
	 <6uzmx87k48.fsf@zork.zork.net> <6uu0ng7je7.fsf@zork.zork.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Mar 2005 19:29:20 +0000, Sean Neakums <sneakums@zork.net> wrote:
> Sean Neakums <sneakums@zork.net> writes:
> 
> > The following happens with 2.6.11-mm[123].  (I didn't have time to
> > investigate earlier; sorry.)  It does not happen with 2.6.11-rc3-mm2
> > and 2.6.11.  I have tested 2.6.11-mm3 with dri disabled (by not
> > loading X's dri module) and it also does not happen then.
> 
> Also happens on 2.6.11-mm3 with bk-drm.patch reverted.
> 
> To expand on my crappy report, the graphics card is a Radeon 9200:

Wierd the -mm tree has currently very few drm changes over the non-mm
tree and if reverting bk-drm doesn't help it sounds like something in
the generic ioctl code may be gone wrong...

Can you try a 2.6.12-bk snapshot.. it may be the multi-head patches
are buggy....

Dave.
