Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751097AbVJOGue@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751097AbVJOGue (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 02:50:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbVJOGue
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 02:50:34 -0400
Received: from nproxy.gmail.com ([64.233.182.202]:62999 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751097AbVJOGud convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 02:50:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Buj3zHjtcJVAHFg3L09O4cJMMRY+lYJeoNav1mjLlcMIgHL8FRmoB1vE/ty7nJ8D4Firy7TpvfrN1W3hcE5rzLG+27s0aFLDkXRJgSiY7eRDbO7IXWmqcJvsAOsF37Txtz6C1arB1t/UzOpetz+BxXSe3z/6IU4AcaPQOI5HYOQ=
Message-ID: <2cd57c900510142350v524a1bc0t1258a0d988aea28d@mail.gmail.com>
Date: Sat, 15 Oct 2005 14:50:32 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
To: Willy Tarreau <willy@w.ods.org>
Subject: Re: Forcing an immediate reboot
Cc: Marc Perkel <marc@perkel.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20051015062125.GK22601@alpha.home.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43505F86.1050701@perkel.com>
	 <20051015062125.GK22601@alpha.home.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/15/05, Willy Tarreau <willy@w.ods.org> wrote:
> On Fri, Oct 14, 2005 at 06:46:46PM -0700, Marc Perkel wrote:
> > Is there any way to force an immediate reboot as if to push the reset
> > button in software? Got a remote server that i need to reboot and
> > shutdown isn't working.
>
> If you can telnet it, simply use this :
>
> # echo 1 >/proc/sys/kernel/sysrq
> # echo b >/proc/sysrq-trigger
>
> It's dirty and you'll have an fsck. But it will nearly always work.

You may avoid the fsck by:

# echo s >/proc/sysrq-trigger
# echo u >/proc/sysrq-trigger

> I use it a lot in local on distros on which the shutdown process is
> as long as the boot process (you know, the ones which display lots
> of 'OK' or wait indefinitely for some dead services to stop, when
> you really want them to reboot quickly).
--
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
