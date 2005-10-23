Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750832AbVJWXNq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750832AbVJWXNq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Oct 2005 19:13:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbVJWXNp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Oct 2005 19:13:45 -0400
Received: from zproxy.gmail.com ([64.233.162.196]:36923 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750832AbVJWXNp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Oct 2005 19:13:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=H5zzBKL682jfR0LLJvCFswpjRps0y3OskxhI6P1Ti+fcYk9IpkWDRm1upOtsWs/5HAPIbp/ItVpT6y3Fp17u5x7FMnM7a3uswBVvg0CsqQ0gvG184AIE9I5bHuBqv7mTOZCXQFlEIy14yNtKfDPtq352tolGo1FmcckDZsZEHiA=
Message-ID: <35fb2e590510231613u492d24c6k4d65ff3ac5ffcee6@mail.gmail.com>
Date: Mon, 24 Oct 2005 00:13:44 +0100
From: Jon Masters <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: /proc/kcore size incorrect ?
Cc: "Linux-Kernel," <linux-kernel@vger.kernel.org>
In-Reply-To: <20051023235806.1a4df9ab@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051023235806.1a4df9ab@werewolf.able.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23/05, J.A. Magallon <jamagallon@able.es> wrote:

> BTW, any simple method to get the real mem of the box ?

This is a typical example of using a hammer to crack a nut aka
modifying the kernel before giving up on userspace.

Several ways of looking up a solution:

    * google
    * man -k memory

Leading to:

* free(1):
    ``free  displays the total amount of free and used physical and swap''

* Or /proc/meminfo (both the same thing) - which you can trivially
parse using sed:

cat /proc/meminfo | sed -n -e "s/^MemTotal:[ ]*\([0-9]*\) kB\$/\1/p"

Jon.
