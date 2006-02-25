Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030241AbWBYN1Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030241AbWBYN1Z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 08:27:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030245AbWBYN1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 08:27:24 -0500
Received: from pproxy.gmail.com ([64.233.166.182]:29929 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030246AbWBYN1X convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 08:27:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CzvhFRbv0C9WOk9+8IWGx07fb2PvUyU85blFwo0Obx6V8m95t28u1Twslwd+iL55tGyAN8FvSHmrea88UKQv1MnppwdphGXjqqS+VjiWtKfjMlfMXhDmZOE/7+9MYypqi+bDZooSQcZXxZ7LSFLStvRoIQhjLnPPR6kPOlBvQDA=
Message-ID: <9a8748490602250527l78e057ecvcd2e656b8ff5c9f2@mail.gmail.com>
Date: Sat, 25 Feb 2006 14:27:20 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Victor Porton" <porton@ex-code.com>
Subject: Re: New reliability technique
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <9a8748490602250526p2187e04ej9a680e6b2b948e7d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <E1FCzMX-0000Ym-00@porton.narod.ru>
	 <9a8748490602250526p2187e04ej9a680e6b2b948e7d@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/25/06, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> On 2/25/06, Victor Porton <porton@ex-code.com> wrote:
> > A minute ago I invented a new reliability enhancing technique.
> >
> > In idle cycles (or periodically in expense of some performance) Linux can
> > calculate MD5 or CRC sums of _unused_ (free) memory areas and compare these
> > sums with previously calculated sums.
> >
> > Additionally it can be done for allocated memory, if it will be write
> > protected before the first actual write. Moreover, all memory may be made
> > write-protected if it is not written e.g. more than a second. (When it
> > is written kernel would unlock it and allow to write, by a techniqie like
> > to how swap works.) If write-protected memory appears to be modified by
> > a check sum, this likewise indicates a bug.
> >
> > If a sum is inequal, it would notice a bug in kernel or in hardware.
> >
> > I suggest to add "Check free memory control sums" in config.
> >
>
> Implement it then and send a patch.
>

But, doesn't slab poisoning and the like already cover this ground somewhat?


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
