Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131993AbRAJLrW>; Wed, 10 Jan 2001 06:47:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135351AbRAJLrC>; Wed, 10 Jan 2001 06:47:02 -0500
Received: from passion.cambridge.redhat.com ([172.16.18.67]:5504 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S131993AbRAJLqy>; Wed, 10 Jan 2001 06:46:54 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.LNX.4.10.10101092255510.3414-100000@penguin.transmeta.com> 
In-Reply-To: <Pine.LNX.4.10.10101092255510.3414-100000@penguin.transmeta.com> 
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Zlatko Calusic <zlatko@iskon.hr>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: Subtle MM bug 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 10 Jan 2001 11:46:03 +0000
Message-ID: <18634.979127163@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


torvalds@transmeta.com said:
>  The no-swap behaviour shoul dactually be pretty much identical,
> simply because both 2.2 and 2.4 will do the same thing: just skip
> dirty pages in the page tables because they cannot do anything about
> them. 

So the VM code spends a fair amount of time scanning lists of pages which 
it really can't do anything about?

Would it be possible to put such pages on different list, so that the VM
code doesn't have to keep skipping them?

(forgive me if I'm displaying my utter ignorance of the VM code here)

--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
