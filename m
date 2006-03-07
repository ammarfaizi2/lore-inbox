Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751208AbWCGNHQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbWCGNHQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 08:07:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751428AbWCGNHQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 08:07:16 -0500
Received: from zproxy.gmail.com ([64.233.162.196]:49893 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751208AbWCGNHO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 08:07:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=n1F+L8UeJZrKWJW5/eNhedxsLAt2c83To7QYWr0mc3xLxUdOthfNXGO3KGp7vmqZmAhvZ4JSp/1Pii+8wqhVxmmLvUyQTOluIkNi3u0kbcROkq3+zqX8MwrTtwXz0RKsHF1rHIZEX2IFvmEn6x+pJcW0/KUFc52CXKBOFxFvWqU=
Message-ID: <9a8748490603070507h48e2fe02qbf9da7956e794161@mail.gmail.com>
Date: Tue, 7 Mar 2006 14:07:13 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Magnus Damm" <magnus.damm@gmail.com>
Subject: Re: SMP and 101% cpu max?
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <aec7e5c30603070434j7f326ad2r5f1b0e8046870941@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <aec7e5c30603070434j7f326ad2r5f1b0e8046870941@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/7/06, Magnus Damm <magnus.damm@gmail.com> wrote:
> Hi guys,
>
> I'm doing some memory related hacking, and part of that is testing the
> current behaviour of the Linux VM. This testing involves running some
> simple tests (building the linux kernel is one of the tests) while
> varying the amount of RAM available to the kernel.
>
> I've tested memory configurations of 64MB, 128MB and 256MB on a Dual
> PIII machine. The tested kernel is 2.6.16-rc5, and user space is based
> on debian-3.1. I run 5 tests per memory configuration, and the machine
> is rebooted between each test.
>
> Problem:
>
> With 128MB and 256MB configurations, a majority of the tests never
> make it over 101% CPU usage when I run "make -j 2 bzImage", building a
> allnoconfig kernel. With 64MB memory, everything seems to be working
> as expected. Also, running "make bzImage" works as expected too.
>
Hmm, I wonder if it's related to the problem I reported here :
http://lkml.org/lkml/2006/2/28/219
Where I need to run make -j 5 or higher to load both cores of my Athlon X2.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
