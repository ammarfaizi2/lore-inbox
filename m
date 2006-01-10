Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932239AbWAJPcb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932239AbWAJPcb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 10:32:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932215AbWAJPcb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 10:32:31 -0500
Received: from zeus1.kernel.org ([204.152.191.4]:40887 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S932235AbWAJPc3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 10:32:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Gzli5oBRgOOnv4K+jNRmI1P4rg1qYw7uP0yJJSZhd81SAT5GbpAytLri4bih2unFkj4NPf+M0S0c+Qi4/7u4gJTPj/YzPSe7MLVJ0UH/UPrQRre2uo88THnIjr7qvUvMGR6MU+kKhCmYkxKmF3C3lWx4deMgeoFtsS1n2P9vcHo=
Message-ID: <81b0412b0601100731p46ec276btfe04382a9e53bd5c@mail.gmail.com>
Date: Tue, 10 Jan 2006 16:31:19 +0100
From: Alex Riesen <raa.lkml@gmail.com>
To: Junio C Hamano <junkio@cox.net>
Subject: Re: git pull on Linux/ACPI release tree
Cc: Linus Torvalds <torvalds@osdl.org>, "Brown, Len" <len.brown@intel.com>,
       "Luck, Tony" <tony.luck@intel.com>,
       Martin Langhoff <martin.langhoff@gmail.com>,
       "David S. Miller" <davem@davemloft.net>, linux-acpi@vger.kernel.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org, git@vger.kernel.org
In-Reply-To: <7vu0cdjhd1.fsf@assigned-by-dhcp.cox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <F7DC2337C7631D4386A2DF6E8FB22B3005A13706@hdsmsx401.amr.corp.intel.com>
	 <Pine.LNX.4.64.0601090835580.3169@g5.osdl.org>
	 <7vu0cdjhd1.fsf@assigned-by-dhcp.cox.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/9/06, Junio C Hamano <junkio@cox.net> wrote:
> 2. Fix "git checkout <branch>" so that it does a reasonable thing
>    even when a dirty path is different in current HEAD and
>    destination branch.  Then I could:
>
>         $ git checkout symref ;# this would not work in the current git
>             # it would die like this:
>             # $ git checkout symref
>             # fatal: Entry 'gitweb.cgi' not uptodate. Cannot merge.

That is actually very interesting. I already wished sometimes to be
able to switch branches with a dirty working directory (and usually
ended up with git diff+checkout+apply).
Even if it results in a merge and conflict markers in files it looks
like a very practical idea!

>         $ git diff ;# just to make sure inevitable automated merge
>                     # did the right thing
>         $ git commit -a -m "Fix symref fix"
>             # I could collapse them into one instead, like this:
>             # $ git reset --soft HEAD^
>             # $ git commit -a -C ORIG_HEAD
