Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263822AbTKSEEG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 23:04:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263824AbTKSEEG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 23:04:06 -0500
Received: from ant.hiwaay.net ([216.180.54.10]:29737 "EHLO mail.hiwaay.net")
	by vger.kernel.org with ESMTP id S263822AbTKSEEE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 23:04:04 -0500
Date: Tue, 18 Nov 2003 22:04:02 -0600
From: Chris Adams <cmadams@hiwaay.net>
To: linux-kernel@vger.kernel.org
Subject: Re: OT: why no file copy() libc/syscall ??
Message-ID: <20031119040402.GA1318449@hiwaay.net>
References: <fa.oc18p1g.1a76jqi@ifi.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p734qx7rmyf.fsf@oldwotan.suse.de>
User-Agent: Mutt/1.4i
Organization: HiWAAY Internet Services
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Once upon a time, Andi Kleen <ak@suse.de> wrote:
>"H. Peter Anvin" <hpa@zytor.com> writes:
>> s/EINTR/short count/, of course :)
>That would be buggy because existing users of sendfile don't know
>about this and would silently only copy part of the file when a signal
>happens.

Tru64 5.1B sendfile(2) page includes:

       [EINTR]
           A signal interrupted  sendfile  before  any  data  was
           transmitted.   If some data was transmitted, the func-
           tion returns the  number  of  bytes  sent  before  the
           interrupt and does not set errno to [EINTR].

There are quite a few more documented return values under Tru64,
although TCP sockets are the only supported destination.  See

http://h30097.www3.hp.com/docs/base_doc/DOCUMENTATION/V51B_HTML/MAN/MAN2/0024____.HTM

-- 
Chris Adams <cmadams@hiwaay.net>
Systems and Network Administrator - HiWAAY Internet Services
I don't speak for anybody but myself - that's enough trouble.
