Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751001AbVJ2RFp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751001AbVJ2RFp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 13:05:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751063AbVJ2RFp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 13:05:45 -0400
Received: from zproxy.gmail.com ([64.233.162.206]:12493 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751001AbVJ2RFo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 13:05:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iVMKHcY7ElHKTekBcSpkJRaTDPGCgJZ1ULy7nq+CENgdDuQarKbAZa7z6i30b2La2CprFVntvHTEtFqj5mAbq0yGWxNrq8ay8SJA+OAex/47oQOuTJFKKMqDhCs/R4+ZITn+tP5tYclH4J8ualDigT31qS8MAJ3CDYLLGBj8gZQ=
Message-ID: <35fb2e590510291005r2ddfca97n330a4d07d3cfde4f@mail.gmail.com>
Date: Sat, 29 Oct 2005 18:05:43 +0100
From: Jon Masters <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: Evgeny Stambulchik <Evgeny.Stambulchik@weizmann.ac.il>
Subject: Re: Weirdness of "mount -o remount,rw" with write-protected floppy
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <35fb2e590510290902y2152f703t56d0cc688f3c64cb@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4360C0A7.4050708@weizmann.ac.il>
	 <35fb2e590510290902y2152f703t56d0cc688f3c64cb@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/29/05, Jon Masters <jonmasters@gmail.com> wrote:

> The /only/ way I can see to "fix" this is to do a pointless open on
> the block device and see if that returns EROFS before allowing a
> remount. But I don't know what other hassle that will cause - I'll
> make the hack, but someone (Al?) who knows the code will need to
> comment because this might completely fuck up a lock somewhere.

Or change the policy for the underlying gendisk in floppy.c according
to what we find when we do an floppy_open on the device. Which is what
I'm looking at as a workaround.

Jon.
