Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261875AbUK2XIQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbUK2XIQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 18:08:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261857AbUK2WyG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 17:54:06 -0500
Received: from rproxy.gmail.com ([64.233.170.203]:39062 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261869AbUK2Wre (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 17:47:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=Yr2rRQ3AxfWl03Gq+YyEsnReaqP7uXCX7eCEZf2umIZ6ARYxjfGgGKXRcy53Iqn34QaqIFV7ogzfdSB6EFJYlF1g8e36T8NvwX3IrpZ1f+MliFAPHJmyQsqrvVd4fHyR10gn2CwhaPeld7b7TU8jyoGKY0pVd7wA92Nrl5RGEDg=
Message-ID: <35fb2e5904112914476df48518@mail.gmail.com>
Date: Mon, 29 Nov 2004 22:47:29 +0000
From: Jon Masters <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: Bernard Normier <bernard@zeroc.com>
Subject: Re: Concurrent access to /dev/urandom
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <006001c4d4c2$14470880$6400a8c0@centrino>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <006001c4d4c2$14470880$6400a8c0@centrino>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Nov 2004 15:45:49 -0500, Bernard Normier <bernard@zeroc.com> wrote:

> I use /dev/urandom to generate UUIDs by reading 16 random bytes from
> /dev/urandom (very much like e2fsprogs' libuuid).

Why not use /dev/random for such data instead?

/dev/urandom suffers from a poor level of entropy if you keep reading
from it over and over again whereas the alternative can block until it
has more randomness available.

Cheers,

Jon.
