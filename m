Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750788AbWJLU5w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788AbWJLU5w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 16:57:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750804AbWJLU5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 16:57:52 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:14754 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750788AbWJLU5v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 16:57:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JA7cpdrGFHpG0fNHrJBKYLl5f+HU0ltnjSeHrBkHHKq/QML99TF+AaSIH6MJzuZ6d0cPIqcje7z2ETvLcOdxDOphqvWZCLBs0YJNccS3hcyAtJZPUGGX5dkOJV9rwYFqp/j9s2QX1jWYpMuNPnQcTuMos688aQh30fHw5fi5D1w=
Message-ID: <6844644e0610121357o501630b7x33962cca30317681@mail.gmail.com>
Date: Thu, 12 Oct 2006 16:57:50 -0400
From: "Doug Reiland" <dreiland@gmail.com>
To: "Frank Sorenson" <frank@tuxrocks.com>
Subject: Re: Kernel panic in 2.6.19-rc1
Cc: "Andrew Morton" <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <452EA73B.4000606@tuxrocks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <452D43B6.8020406@tuxrocks.com>
	 <20061012000643.f875c96e.akpm@osdl.org>
	 <452E93D7.6020004@tuxrocks.com>
	 <20061012125714.a44c3a1d.akpm@osdl.org>
	 <452EA73B.4000606@tuxrocks.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had similiar problems moving from 2.6.18 to 2.6.19-rc1. It might
have something to do with me using a new kernel on an old
distributation, but things like INIT need sysctl.

I had a time getting CONFIG_SYSCTL_SYSCALL=y to stick so I changed the
kernel/sysctl.c ifdefs. You might try and it looks like you are using
x86_64 so double check for usage of that define under arch/x86_64. I
thought I saw it under the 32bit emulation stuff.

Boot just fine after this.
