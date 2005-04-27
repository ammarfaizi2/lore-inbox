Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261738AbVD0PbD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261738AbVD0PbD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 11:31:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261740AbVD0PbD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 11:31:03 -0400
Received: from zproxy.gmail.com ([64.233.162.207]:25449 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261738AbVD0Pa6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 11:30:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PbmpubRHTFfcdyiN99oVa4am/hj3A3jaeFttpLpgTJjjifMKTpkIWJc1hZV5vs9RRdesrvoQihh6ss6HvHg+9YWyWzmzA3aAO9oE48uobE+cz8R8uU25jpzYnSe/F9IIqtMzZVHqNrse8ycM/maanOcTlpMzml7JoQ7wGIDT/s8=
Message-ID: <699a19ea05042708305fb7194b@mail.gmail.com>
Date: Wed, 27 Apr 2005 21:00:58 +0530
From: k8 s <uint32@gmail.com>
Reply-To: k8 s <uint32@gmail.com>
To: k8 s <uint32@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Doubt Regarding Multithreading and Device Driver
In-Reply-To: <20050427151040.GA5717@roonstrasse.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <699a19ea050427080545fb1676@mail.gmail.com>
	 <20050427151040.GA5717@roonstrasse.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

But i am sharing something in file->private_data which is a private
variable to the process(that is passed to the device driver
functions). Isn't it?

SK

On 4/27/05, Max Kellermann <max@duempel.org> wrote:
> On 2005/04/27 17:05, k8 s <uint32@gmail.com> wrote:
> > I am storing something into struct file*filp->private_data.
> > As this is not shared across processes I am not doing any locking
> > stuff while accessing or putting anything into it.
> 
> You're talking about kernel variables, aren't you? Kernel memory is
> shared among all processes, i.e. you _do_ need locking.
> 
> Max
> 
>
