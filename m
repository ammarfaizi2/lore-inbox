Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262775AbVD2O5G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262775AbVD2O5G (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 10:57:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262783AbVD2Oyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 10:54:45 -0400
Received: from mail.shareable.org ([81.29.64.88]:10411 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262755AbVD2OvD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 10:51:03 -0400
Date: Fri, 29 Apr 2005 15:50:42 +0100
From: Jamie Lokier <jamie@shareable.org>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Miklos Szeredi <miklos@szeredi.hu>, linuxram@us.ibm.com, ericvh@gmail.com,
       pavel@ucw.cz, hch@infradead.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Question about current->namespace and check_mnt()
Message-ID: <20050429145042.GC17263@mail.shareable.org>
References: <20050425190734.GB28294@mail.shareable.org> <20050426092924.GA4175@elf.ucw.cz> <20050426140715.GA10833@mail.shareable.org> <a4e6962a050428064774e88f4a@mail.gmail.com> <20050428192048.GA2895@mail.shareable.org> <1114717183.4180.718.camel@localhost> <20050428220839.GA5183@mail.shareable.org> <1114761430.4180.1566.camel@localhost> <E1DRWEt-000149-00@dorka.pomaz.szeredi.hu> <20050429144252.GA17263@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050429144252.GA17263@mail.shareable.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Al,

I have a specific namespace.c question:

I really like to know what the purpose of check_mnt() is in
namespace.c.  In standard kernels you can't enter another process'
namespace so I don't see how check_mnt() can _ever_ fail.  Can it
fail, or in other words, what is the purpose of that check?

And if it can't fail, is there really a need for current->namespace, or
can it just be removed?

Also, I would think the current process' rootmnt->mnt_namespace would
adequately define the "current process namespace", so making
current->namespace redundant in that way.  Is that right?

Thanks,
-- Jamie
