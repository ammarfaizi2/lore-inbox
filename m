Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263433AbVBDBYH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263433AbVBDBYH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 20:24:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262946AbVBDBVl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 20:21:41 -0500
Received: from sv1.valinux.co.jp ([210.128.90.2]:55957 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S261766AbVBDBHb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 20:07:31 -0500
Date: Fri, 04 Feb 2005 10:07:34 +0900
From: Itsuro Oda <oda@valinux.co.jp>
To: Itsuro Oda <oda@valinux.co.jp>
Subject: Re: [Fastboot] [PATCH] Reserving backup region for kexec based crashdumps.
Cc: ebiederm@xmission.com (Eric W. Biederman),
       Koichi Suzuki <koichi@intellilink.co.jp>,
       Vivek Goyal <vgoyal@in.ibm.com>, Andrew Morton <akpm@osdl.org>,
       fastboot <fastboot@lists.osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Maneesh Soni <maneesh@in.ibm.com>,
       Hariprasad Nellitheertha <hari@in.ibm.com>,
       suparna bhattacharya <suparna@in.ibm.com>
In-Reply-To: <20050204074755.18EA.ODA@valinux.co.jp>
References: <m14qgu81bw.fsf@ebiederm.dsl.xmission.com> <20050204074755.18EA.ODA@valinux.co.jp>
Message-Id: <20050204100522.18F6.ODA@valinux.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.10.04 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 04 Feb 2005 08:18:56 +0900
Itsuro Oda <oda@valinux.co.jp> wrote:

> 
> > > 5) dump kernel: export all valid physical memory (and saved register
> > >    information) to the user. (as /dev/oldmem /proc/vmcore ?)
> > 
> > Or in user space, by just mmaping /dev/mem. That is part of the
> > current conversation.   The only real point for putting that code in
> > the kernel (besides momentum) is it is a cheap way to get the exact
> > data structures of the kernel you are using.  But since:
> > (a) it does not look like any primary kernel data structures need to
> >     be examined.
> > (b) even simple compile options like SMP/NOSMP are enough to change
> >     the layout of the data structures.
> > I think there is a pretty good case for moving all of the work to
> > user space.  But you still need a kernel that loads and
> > runs in the reserved area.
> > 
> I don't make sense. what do you mean ?
> 

"I don't make sense." should be "It does not make sense."
sorry. I'm not familiar with English.

-- 
Itsuro ODA <oda@valinux.co.jp>

