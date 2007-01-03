Return-Path: <linux-kernel-owner+w=401wt.eu-S1752881AbXACBSm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752881AbXACBSm (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 20:18:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752903AbXACBSm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 20:18:42 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:35853 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752871AbXACBSl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 20:18:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tNMMl4qaZrXKmsepr9ID8m/JvzHQbF9IVedc3YJMK0Lwv/PS/9S0PCGSMfdXcMlR1I47KhYSmFF5fONalvprxouqycjgMYHWpDJmv4H5qI7AzFkchmVtb6Mbom9LV0ENV/mwSPbUL5C9uiWjXjzjVKFqonLCNSO+Fcm9rpZQTJY=
Message-ID: <6f703f960701021718qb85f4bdg58d8ee0923376191@mail.gmail.com>
Date: Tue, 2 Jan 2007 16:18:40 -0900
From: "Kent Overstreet" <kent.overstreet@gmail.com>
To: "Zach Brown" <zach.brown@oracle.com>
Subject: Re: [RFC] Heads up on a series of AIO patchsets
Cc: linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <A85B8249-FC4E-4612-8B28-02BC680DC812@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061227153855.GA25898@in.ibm.com>
	 <5A322D46-A73A-43DD-8667-CE218DDA48B0@oracle.com>
	 <6f703f960701021640y444bc537w549fd6d74f3e9529@mail.gmail.com>
	 <A85B8249-FC4E-4612-8B28-02BC680DC812@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Any details?
>
> Well, one path I tried I couldn't help but post a blog entry about
> for my friends.  I'm not sure it's the direction I'll take with linux-
> kernel, but the fundamentals are there:  the api should be the
> syscall interface, and there should be no difference between sync and
> async behaviour.
>
> http://www.zabbo.net/?p=72

Any code you're willing to let people play with? I could at least have
real test cases, and a library to go along with it as it gets
finished.

Another pie in the sky idea:
One thing that's been bugging me lately (working on a 9p server), is
sendfile is hard to use in practice because you need packet headers
and such, and they need to go out at the same time.

Sendfile listio support would fix this, but it's not a general
solution. What would be really usefull is a way to say that a certain
batch of async ops either all succeed or all fail, and happen
atomically; i.e., transactions for syscalls.

Probably even harder to do than general async syscalls, but it'd be
the best thing since sliced bread... and hey, it seems the logical
next step.
