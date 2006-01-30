Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964956AbWA3Uch@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964956AbWA3Uch (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 15:32:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964958AbWA3Ucg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 15:32:36 -0500
Received: from uproxy.gmail.com ([66.249.92.196]:50336 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964956AbWA3Ucf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 15:32:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ackDQeMWJQBGulpKPGsovjs5MalC3Mj5L6D/cRbQUDtnT/Hc/8800zE9QFsx+iGFMzHi6ckEbaRkH8VQ3OdiJkSW+1I6wMIOUuR80W/lUgb019rpTTdv252n48xMVN32rCjOagibgTttr//sIEHVrSpMXJeSyaayui0Zy8iR+Hc=
Message-ID: <728201270601301232v6da6fc2el7148ec33896d6b97@mail.gmail.com>
Date: Mon, 30 Jan 2006 20:32:33 +0000
From: Ram Gupta <ram.gupta5@gmail.com>
To: Bernard Blackham <bernard@blackham.com.au>
Subject: Re: Unique /proc/<pid>/fd/ inode numbers?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060130163748.GC8154@blackham.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060130163748.GC8154@blackham.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/30/06, Bernard Blackham <bernard@blackham.com.au> wrote:
> A useful thing to be able to determine when checkpointing a process
> from userspace is whether two file descriptors that point to the
> same file are
>    (a) two independently open()'d instances of the file; or
>    (b) one open() and one dup().
> (the latter case meaning the FDs share locks & seek offsets).
>

I dont see a way  which differentiates between open fd & dup fd. The
only  difference between them is that when doing open it allocates a
new file structure & initializes it while in case of dup the same file
pointer. That's how you share the locks & seek offsets. But I dont see
any kernel code which makes this difference currently. Implementing
this should not be that hard any way

regards
Ram Gupta
