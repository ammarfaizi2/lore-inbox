Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262192AbTEENaC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 09:30:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262197AbTEENaC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 09:30:02 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:50442 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262192AbTEEN37 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 09:29:59 -0400
Date: Mon, 5 May 2003 14:42:29 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Dmitry A. Fedorov" <D.A.Fedorov@inp.nsk.su>
Cc: Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: The disappearing sys_call_table export.
Message-ID: <20030505144229.A23483@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Dmitry A. Fedorov" <D.A.Fedorov@inp.nsk.su>,
	Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
References: <Pine.SGI.4.10.10305051745290.8200163-100000@Sky.inp.nsk.su>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.SGI.4.10.10305051745290.8200163-100000@Sky.inp.nsk.su>; from D.A.Fedorov@inp.nsk.su on Mon, May 05, 2003 at 08:30:38PM +0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I use the following calls:
> 
> sys_mknod
> sys_chown
> sys_umask
> sys_unlink
> 
> for creating/deleting /dev entries dynamically on driver
> loading/unloading. It allows me to acquire dynamic major
> number without devfs and external utility of any kind.
> And there is no risk of intersection with statically assigned major
> numbers, as it is for many others third-party sources.

You don't want to tell me you do that for real, do you?
That alone is a very good idea to unexport the syscall table without
exporting those symbols..
