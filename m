Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751251AbWELLsu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251AbWELLsu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 07:48:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbWELLsu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 07:48:50 -0400
Received: from wr-out-0506.google.com ([64.233.184.224]:41532 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751251AbWELLst convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 07:48:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FPV6I7B1BHAbFw2n4ySAJipHidDBQZ0hxpKjudkzNNmv2YQgMfVrGfKH4j0siBoHuGdKFMq6aWYgYUcU4CzDEWuEBUJMHEowd5xU+n2WX9l4okAHADjoGHooK0qSrlH0aNKSG54zlUZBu4wVwOgjyFcIZvBCFe6E9mGnn/hdWE8=
Message-ID: <9a8748490605120448i506ca5b9ra428bb460f0e94d0@mail.gmail.com>
Date: Fri, 12 May 2006 13:48:48 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Daniel Walker" <dwalker@mvista.com>
Subject: Re: [PATCH -mm] updated idetape gcc 4.1 warning fix
Cc: akpm@osdl.org, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <200605101759.k4AHxhUI005075@dwalker1.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200605101759.k4AHxhUI005075@dwalker1.mvista.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/06, Daniel Walker <dwalker@mvista.com> wrote:
> I added returns for failures .. I would hope that this doesn't break anything in
> userspace , but I'll confess that I have no way to determin that for certain .
>
> Hows that Alan?
>
> Fixes the following warning,
>
> drivers/ide/ide-tape.c: In function 'idetape_copy_stage_from_user':
> drivers/ide/ide-tape.c:2662: warning: ignoring return value of 'copy_from_user', declared with attribute warn_unused_result
> drivers/ide/ide-tape.c: In function 'idetape_copy_stage_to_user':
> drivers/ide/ide-tape.c:2689: warning: ignoring return value of 'copy_to_user', declared with attribute warn_unused_result
>

I've been down the road of trying to fix that code as well a while back.
Although my patches had flaws and didn't go in, perhaps your current
attempt could bennefit by looking at what I tried to do back then and
the feedback I recieved, so I thought I'd point them out to you.

Take a look at the two threads named "[PATCH] ide-tape: attempt to
handle copy_*_user() failures" and "[PATCH] ide-tape: attempt to
handle copy_*_user() failures [take two]"

Here's a link to them in the archives :
http://marc.theaimsgroup.com/?t=113796611500003&r=1&w=2


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
