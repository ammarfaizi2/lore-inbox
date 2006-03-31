Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751165AbWCaG7X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751165AbWCaG7X (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 01:59:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751198AbWCaG7X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 01:59:23 -0500
Received: from nproxy.gmail.com ([64.233.182.189]:49719 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751165AbWCaG7X convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 01:59:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eVya+sNF7AGnbfJ9pBrZQlj4q8zLDcK1L12pgDC+hn8YDx0vV6TVdr4qG7g1RTJWk7TNvw9Xgmct90bfIaNrHQc6xRncE9yb/JDTHbTot7ZfEBCsqUMHn93b9u1ncya1KZumjbfPeQAzio/SJs8tFvBbQoLgiugUY2zmJv6uNjY=
Message-ID: <69304d110603302259geac2ba8t11babc2c6854842d@mail.gmail.com>
Date: Fri, 31 Mar 2006 08:59:19 +0200
From: "Antonio Vargas" <windenntw@gmail.com>
To: tridge@samba.org
Subject: Re: [PATCH] splice support #2
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <17452.50912.404106.256236@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <17452.50912.404106.256236@samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/31/06, tridge@samba.org <tridge@samba.org> wrote:
> Linus and Jens,
>
> Stephen Rothwell just pointed me at the new splice() interface. Looks
> really nice!
>
> One comment though. Could we add a off_t to splice to make it more
> like pwrite() ? Otherwise threads could get painful with race
> conditions between the seek and the splice() call.
>
> Either that or add psplice() like this:
>
>   ssize_t psplice(int fdin, int fdout, size_t len, off_t ofs, unsigned flags);
>
> where ofs sets the offset to read from fdin.
>
> Cheers, Tridge

Maybe "ssize_t psplice(int fdin, int fdout, size_t len, off_t
fdin_ofs, unsigned flags);"
would be better at documenting that the offset is for the input? Or
maybe adding also a fdout_ofs for when fdout is also a file...

--
Greetz, Antonio Vargas aka winden of network

http://wind.codepixel.com/
windNOenSPAMntw@gmail.com
thesameasabove@amigascne.org

Every day, every year
you have to work
you have to study
you have to scene.
