Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964892AbWAISBs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964892AbWAISBs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 13:01:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964894AbWAISBr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 13:01:47 -0500
Received: from wproxy.gmail.com ([64.233.184.204]:9954 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964892AbWAISBq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 13:01:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BbuknrU4C3DDyjv+Ezkh1C9MsTLt6+yt1qiu0JHMrNqGysHJZNqOfCiOp0r01V5XU7sv6kgRhdxvclpwe1CLSdjat4tfOdQI9s7stz1K8CiUvw0f9jE7ADI+Hn6AH6DzMNR/+2QkOJpxR5iAJ+a4t8Glp0QreQ2NiJs5qNWCXEU=
Message-ID: <9a8748490601091001y74fba5q2cd7e08a324701c3@mail.gmail.com>
Date: Mon, 9 Jan 2006 19:01:44 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Dave Jones <davej@redhat.com>, Jesper Juhl <jesper.juhl@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-mm2
In-Reply-To: <20060109175748.GD25102@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060107052221.61d0b600.akpm@osdl.org>
	 <9a8748490601070708p4353eb0ev9ea15edee132b13b@mail.gmail.com>
	 <9a8748490601090947i524d5f73uf5ccd06d8c693cae@mail.gmail.com>
	 <20060109175748.GD25102@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/9/06, Dave Jones <davej@redhat.com> wrote:
> On Mon, Jan 09, 2006 at 06:47:01PM +0100, Jesper Juhl wrote:
>
>  > Here's what bad_page printed for me :
>  >
>  > Bad page state in process 'kded'
>  > [<c0103e77>] dump_stack+0x17/0x20
>  > [<c0148999>] bad_page+0x69/0x160
>
> Odd, there should be more state between the 'Bad page'
> and the backtrace.
>
>     printk(KERN_EMERG "Bad page state in process '%s'\n"
>                 "page:%p flags:0x%0*lx mapping:%p mapcount:%d count:%d\n"
>                 "Trying to fix it up, but a reboot is needed\n"
>
> Did you aggressively trim that, or did it for some
> reason not get printed ?
>

I did not trim that.

All I did was add

 printk(KERN_EMERG "we hit bad page, looping forever\n");
 while (1) {
    mdelay(1000);
 }

to the end of bad_page()

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
