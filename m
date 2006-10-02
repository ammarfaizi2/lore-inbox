Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932265AbWJBQ5F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932265AbWJBQ5F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 12:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932509AbWJBQ5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 12:57:04 -0400
Received: from nz-out-0102.google.com ([64.233.162.195]:4262 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932265AbWJBQ5C (ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 12:57:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=FvuZ0Kc5OWpl+gGiRLZFSHsGAR+r4x9I6Ld+LaWiBTSj2djUyavKtvPBd7saad9ZHO57O+BoveI6enKxn69mJwSM+MXhrdJ3KZh391mrVD9BTB3ferV91M3wttuRVt98UhSEYPJrzZiJwZTvm0sFuk9umvmlDcuD2joI7N8gKV4=
Message-ID: <3282373b0610020957u739392eekf8b78c7574e1a6e7@mail.gmail.com>
Date: Mon, 2 Oct 2006 09:57:01 -0700
From: "Tim Chen" <tim.c.chen@intel.com>
To: "Trond Myklebust" <trond.myklebust@fys.uio.no>
Subject: Re: Postal 56% waits for flock_lock_file_wait
Cc: "Ananiev, Leonid I" <leonid.i.ananiev@intel.com>,
       "Linux Kernel Mailing List" <Linux-Kernel@vger.kernel.org>
In-Reply-To: <1159723092.5645.14.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <B41635854730A14CA71C92B36EC22AAC3AD954@mssmsx411>
	 <1159723092.5645.14.camel@lade.trondhjem.org>
X-Google-Sender-Auth: 045f032016e3782a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/1/06, Trond Myklebust <trond.myklebust@fys.uio.no> wrote:

>
> I still don't get it. The job of the flock() system call is to sleep if
> someone already holds the lock, and then grab the lock when it is
> released. If that is not what the user expects, then the user has the
> option of not calling flock(). This has nothing to do with open().
>
> Trond
>

If I understand Leonid correctly, I think what he is saying is ext3
does not scale very well when you have a large number of processes
acessing file system because of locks in journal.    This is seen in
the excessive idle time.  By comparison, ext2 does not have this
issue.

Tim
