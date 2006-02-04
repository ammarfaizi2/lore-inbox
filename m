Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932349AbWBDQS0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932349AbWBDQS0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 11:18:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932500AbWBDQS0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 11:18:26 -0500
Received: from wproxy.gmail.com ([64.233.184.197]:62512 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932349AbWBDQSZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 11:18:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NzG0tvse7EhAUbQl8hw+5uoCugfpXe2dWjKyKoa0xEGSCSaQjxNgGs1yiMBn6RMaPMLtXXukX3Cd0Joqs8TZQZat6q1H/vMbCxr6IzFkkV++kE8WZqzildHU0rMkzWPPXnwzaC4/rHgFCNrlwIaQe4DKb0yBvB1nRNdQcTkYZow=
Message-ID: <9a8748490602040818y72c59c67wc6b6bb1c3e40956b@mail.gmail.com>
Date: Sat, 4 Feb 2006 17:18:24 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Ben Castricum <lk@bencastricum.nl>
Subject: Re: 2.6.16-rc[12] weirdness
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <000701c629a4$5df090e0$0602a8c0@links>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <000701c629a4$5df090e0$0602a8c0@links>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/4/06, Ben Castricum <lk@bencastricum.nl> wrote:
> I just want to report a couple of things I think are kernel related (since
> they only occur when I run 2.6.16-rc*) but are too weird to be sure.
>
[snip]
>
> My /dev/null device gets replaced by a file. Some of my cronjobs have a
>  >/dev/null and can see the ouput of the scripts in /dev/null. Deleting the
> file and recreating the device again is fixes this. And again.. this seems
> to happen randomly.
>
You are probably building your kernels as root. There's a problem in
kbuild that causes it to replace /dev/null with a regular file on some
systems - it's been fixed but the fix is not yet in mainline.
But, you shouldn't be building kernels as root anyway.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
