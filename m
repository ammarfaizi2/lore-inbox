Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423223AbWKPKQA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423223AbWKPKQA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 05:16:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423303AbWKPKP7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 05:15:59 -0500
Received: from wx-out-0506.google.com ([66.249.82.227]:64532 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1423223AbWKPKP7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 05:15:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Jh9/LpmKLGr7UeLffob4Vz1sikWgyuNAKPVzhbS9IVnp2pSfb8M5/fTEYG48+S9eUEcM/mUbJrouT3+NQBsghARWSrnZ9LrsNNeq6DiaPbaLxVYsUj7FMr4odM37vz/QsokJY/E7xpflTIMn+CQl+D5YilYj2d4rQ0vWQ4d5Y0o=
Message-ID: <f36b08ee0611160215i7dcbd27p76963cb12d0bc12f@mail.gmail.com>
Date: Thu, 16 Nov 2006 12:15:58 +0200
From: "Yakov Lerner" <iler.ml@gmail.com>
To: "Phillip Susi" <psusi@cfl.rr.com>
Subject: Re: locking sectors of raw disk (raw read-write test of mounted disk)
Cc: Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <455B8979.6090101@cfl.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <f36b08ee0611151206k50284ef9n43d7edf744ae2f19@mail.gmail.com>
	 <455B8979.6090101@cfl.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/06, Phillip Susi <psusi@cfl.rr.com> wrote:
> No, you can not tamper with the underlying data while the kernel has it
> mounted.
I don't want to tamper wuith data. I want to raw write back exacty
same raw data that I read in. I only want to make sure that kernel
doesn't write modified data between in between my read-write pair.

Yakov


> Yakov Lerner wrote:
> > I'd like to make read-write test of the raw disk, and disk has
> > mounted partitions. Is it possible to lock  range of sectors
> > of the raw device so that any kernel code that wants to write
> > to this range will sleep ? (so that test
> >    { lock range; read /dev/hda->buf; write buf->/dev/hda; unlock }
> > won't corrupt the filesysyem ?)
> >
> > Thanks
> > Yakov
>
>
