Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964807AbWH2Ji3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964807AbWH2Ji3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 05:38:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964812AbWH2Ji3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 05:38:29 -0400
Received: from wx-out-0506.google.com ([66.249.82.234]:49135 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964807AbWH2Ji2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 05:38:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=d+zrsbNIyGJ7uxwKlqz9pXEzytewo5ian6wqi8sVTsqPyKmRn3I7em8PuIakKtyDBacZ2OtP5VopX/lEi9CsJK95GGOfegJm5XvLcDgmvGcFKRdpJ8Zll8HJpE9oBehjMMWKCFVAsOkYTzCc/T47cOn5sYS4YPBhhUiWa3C3HnU=
Message-ID: <1defaf580608290238k584af24fjc97ddb276706a423@mail.gmail.com>
Date: Tue, 29 Aug 2006 11:38:27 +0200
From: "Haavard Skinnemoen" <hskinnemoen@gmail.com>
To: "David Howells" <dhowells@redhat.com>
Subject: Re: [PATCH 0/7] kill __KERNEL_SYSCALLS__
Cc: "Arnd Bergmann" <arnd@arndb.de>, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org, "Jeff Dike" <jdike@addtoit.com>,
       "Bjoern Steinbrink" <B.Steinbrink@gmx.de>,
       "Arjan van de Ven" <arjan@infradead.org>,
       "Chase Venters" <chase.venters@clientec.com>,
       "Andrew Morton" <akpm@osdl.org>,
       "Russell King" <rmk+lkml@arm.linux.org.uk>, rusty@rustcorp.com.au
In-Reply-To: <10191.1156842767@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060827214734.252316000@klappe.arndb.de>
	 <10191.1156842767@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/29/06, David Howells <dhowells@redhat.com> wrote:
> Arnd Bergmann <arnd@arndb.de> wrote:
>
> > Ok, next try. This time a full series that tries to kill
> > off __KERNEL_SYSCALLS__, _syscallX() and the global errno
> > for good.
>
> Have you checked uClibc?  Does that use _syscallX()?

At least the latest version provides its own set of _syscallX()
macros. I removed _syscallX() from the AVR32 kernel a few weeks ago as
suggested by David Woodhouse, and uClibc doesn't seem to have a
problem with it.

Haavard
