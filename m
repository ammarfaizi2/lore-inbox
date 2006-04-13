Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751082AbWDMQ4N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751082AbWDMQ4N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 12:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbWDMQ4N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 12:56:13 -0400
Received: from minus.inr.ac.ru ([194.67.69.97]:2755 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id S1751082AbWDMQ4M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 12:56:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=ms2.inr.ac.ru;
  b=RZ3Gc8fZPPnBM9YAxj9Eo2FsRWxN7DlAe9TudouxzD/kG62idD2citspFI8YSyxicRDqJ+1EM8bztAT/aDyHjTuomwjeDbqO9MI4zLJ+VWwL+g1VXjM8A/rhOXkX7fNszpSo+gGQJlXE4aP4FSKJ0XH12ZVz9igmRdJ2LfWshtg=;
Date: Thu, 13 Apr 2006 20:54:06 +0400
From: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
To: Andi Kleen <ak@suse.de>
Cc: Kirill Korotaev <dev@sw.ru>, Kir Kolyshkin <kir@openvz.org>, akpm@osdl.org,
       Nick Piggin <nickpiggin@yahoo.com.au>, sam@vilain.net,
       linux-kernel@vger.kernel.org,
       "Eric W. Biederman" <ebiederm@xmission.com>, serue@us.ibm.com,
       herbert@13thfloor.at
Subject: Re: [Devel] Re: [RFC] Virtualization steps
Message-ID: <20060413165406.GA7261@ms2.inr.ac.ru>
References: <1143228339.19152.91.camel@localhost.localdomain> <200603282029.AA00927@bbb-jz5c7z9hn9y.digitalinfra.co.jp> <4429A17D.2050506@openvz.org> <443151B4.7010401@tmr.com> <443B873B.9040908@sw.ru> <p73mzer4bti.fsf@bragg.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73mzer4bti.fsf@bragg.suse.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> How would that work when x86-64 32bit programs have 4GB of address
> space and native on i386 programs only 3GB?

It is not the only obstacle. There are another ones:

1. Different values of segment registers. __USER32_* selectors should match
   ones on i386.
2. ia32 vsyscall page. It also must be the same, unless arch/i386 is changed
   to allow various mappins like 32bit page x86_64 works.

Well, if we want something to migrate, we have to pay.

Alexey
