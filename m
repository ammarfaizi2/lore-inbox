Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262334AbTEEOrB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 10:47:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262298AbTEEOpj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 10:45:39 -0400
Received: from inpbox.inp.nsk.su ([193.124.167.24]:5762 "EHLO
	inpbox.inp.nsk.su") by vger.kernel.org with ESMTP id S262334AbTEEOpe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 10:45:34 -0400
Date: Mon, 5 May 2003 21:46:44 +0700
From: "Dmitry A. Fedorov" <D.A.Fedorov@inp.nsk.su>
Reply-To: D.A.Fedorov@inp.nsk.su
To: Christoph Hellwig <hch@infradead.org>
cc: Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: The disappearing sys_call_table export.
In-Reply-To: <20030505144229.A23483@infradead.org>
Message-ID: <Pine.SGI.4.10.10305052130530.8200163-100000@Sky.inp.nsk.su>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 May 2003, Christoph Hellwig wrote:

> > I use the following calls:
> > 
> > sys_mknod
> > sys_chown
> > sys_umask
> > sys_unlink
> > 
> > for creating/deleting /dev entries dynamically on driver
> > loading/unloading. It allows me to acquire dynamic major
> > number without devfs and external utility of any kind.
> > And there is no risk of intersection with statically assigned major
> > numbers, as it is for many others third-party sources.
> 
> You don't want to tell me you do that for real, do you?

I do that for real.
Please, think about it as small portable private devfs library.

> That alone is a very good idea to unexport the syscall table without
> exporting those symbols..

It does not helps, I would find another way, maybe vfs_* calls
or proc_mknod, unexport it too.

