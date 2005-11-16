Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030231AbVKPLW4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030231AbVKPLW4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 06:22:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030236AbVKPLWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 06:22:55 -0500
Received: from zproxy.gmail.com ([64.233.162.204]:14007 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030231AbVKPLWz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 06:22:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hrG7ow4iji8YXi2U9RYN1gWIELEjY9EEkeYx2Fky3SGuWg2MWY1JNfq7cTfAkz1AsYGhZi8T218V+9MImCOHr02DBI4X0x6++FUAC5DgTNk9HCE8dpN75TosQSE0COxPthdZk5nI0K8H50XolhbD5Q3Bcc2bmjy0w/FqDGihJ9w=
Message-ID: <35fb2e590511160322v48440202y47cce6cfd83a51ab@mail.gmail.com>
Date: Wed, 16 Nov 2005 11:22:54 +0000
From: Jon Masters <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: Andrew Morton <akpm@osdl.org>
Subject: Re: floppy regression from "[PATCH] fix floppy.c to store correct ..."
Cc: Cal Peake <cp@absolutedigital.net>, linux-kernel@vger.kernel.org,
       jcm@jonmasters.org, torvalds@osdl.org, viro@ftp.linux.org.uk,
       hch@lst.de
In-Reply-To: <20051116005958.25adcd4a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.61.0511160034320.988@lancer.cnet.absolutedigital.net>
	 <20051116005958.25adcd4a.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/05, Andrew Morton <akpm@osdl.org> wrote:

> hmm, yes, when floppy_open() does its test we haven't yet gone and
> determined the state of FD_DISK_WRITABLE.  On later opens, we
> have done, so things work OK.

I'll fix this later on today.

> We may be able to do the test at the end of floppy_open(), after
> check_disk_change() has called floppy_revalidate().  But for
> O_NDELAY opens we appear to be screwed.

Give me a few hours to take a look at it. I'll move the test and look
at the latter case and get back to you.

Jon.
