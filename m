Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261675AbUKPKW0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261675AbUKPKW0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 05:22:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261762AbUKPKWR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 05:22:17 -0500
Received: from canuck.infradead.org ([205.233.218.70]:56840 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261675AbUKPKWE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 05:22:04 -0500
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
From: David Woodhouse <dwmw2@infradead.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: arjan@infradead.org, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <E1CU00w-0000cM-00@dorka.pomaz.szeredi.hu>
References: <E1CToBi-0008V7-00@dorka.pomaz.szeredi.hu>
	 <Pine.LNX.4.58.0411151423390.2222@ppc970.osdl.org>
	 <E1CTzKY-0000ZJ-00@dorka.pomaz.szeredi.hu>
	 <1100596704.2811.17.camel@laptop.fenrus.org>
	 <E1CTzpJ-0000ap-00@dorka.pomaz.szeredi.hu>
	 <1100598372.2811.21.camel@laptop.fenrus.org>
	 <E1CU00w-0000cM-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain
Date: Tue, 16 Nov 2004 10:17:51 +0000
Message-Id: <1100600272.30283.27.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-11-16 at 10:52 +0100, Miklos Szeredi wrote:
> > yes but how do you know the entry is still on the list and valid ?
> 
> Because, it's always kept on one of two lists: pending and processing.
> The entry is valid valid because it's "owned" by the caller, it's
> never freed inside request_send().
> 
> > you dropped the lock. A normal code pattern is that you then HAVE 
> > to revalidate the assumptions which you guard by that lock.
> 
> The lock guards the list not the list element which is being removed.

Locking rules like that need to be clearly documented.

-- 
dwmw2

