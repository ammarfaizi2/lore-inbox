Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751335AbWAVUJS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335AbWAVUJS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 15:09:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751336AbWAVUJS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 15:09:18 -0500
Received: from wproxy.gmail.com ([64.233.184.197]:13032 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751334AbWAVUJR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 15:09:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=I6/ZjiNFFK8lsDXSCFnZtItxyNmwRDnKkX9HOmDhPveU5W5pcppsSMYrlF8iqMGBN/w0lMtmAXCxyI+E9/lNXZqfFJdOMBb88hDpqHkW4ZUJGtCLFgZBYxHN1OZ5lEzfLd9oumUUHI/Qf58ZJiE6FgGHIttrXl5kpCKtyUiopeM=
Message-ID: <787b0d920601221202q6e4e95ccrab1cf009468e10f1@mail.gmail.com>
Date: Sun, 22 Jan 2006 15:02:20 -0500
From: Albert Cahalan <acahalan@gmail.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: [PATCH] add /proc/*/pmap files
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <Pine.LNX.4.61.0601221532270.16919@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <787b0d920601220150n2e34e376i856cc583a372e1f2@mail.gmail.com>
	 <Pine.LNX.4.61.0601221532270.16919@yvahk01.tjqt.qr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/22/06, Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
>
> >This adds a few things needed by the pmap command.
> >They show up in /proc/*/pmap files.
>
> But my pmap command works without the /proc/$$/pmap file?

The -x option doesn't show locked memory, etc.

I'll still be missing a few things, but perhaps they just
don't make sense for Linux today. Solaris has them.

For example, Solaris can report how much swap space
each mapping has reserved and how much it has used.
I don't think we remember per-mapping reservations yet
AFAIK, Linux can't tell which mapping to blame if we run
out of memory.

If mlock() might work on only part of a mapping, then
a mere flag won't do. Adding this later is now easy,
though the flag would need to remain.

> >If the patch doesn't make it to the list intact, somebody
> >please give me a hand. Non-mangling email systems are
> >getting to be kind of exotic these days.  :-(
>
> Send it as MIME attachment then :o)

Doesn't the mailing list trash posts with MIME?
I still remember how to use uuencode though:

begin 644 diff.gz
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
;+^\NAOGTGX\P?N(9DY?&&++E?XQ&+`*I'@``
`
end
