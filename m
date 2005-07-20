Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261179AbVGTNAX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbVGTNAX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 09:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261191AbVGTNAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 09:00:23 -0400
Received: from zproxy.gmail.com ([64.233.162.199]:56858 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261179AbVGTNAV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 09:00:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=g4VbFsmgTw6pZxR5u85kz36TE11X+rr9rdjvwqaHmIEBnJoQvd3e3Bc3XQfIoZJ+BwIUm+60+jByMre3LqwVcLTZwI2GFsy75dLAgwDNOPzI1AYAC6v33bplU7DMqYhhHZCHANvAcZUF7wpPrswWXlJLWzDXIB0viJdUlhO8744=
Message-ID: <9a87484905072005596f2c2b51@mail.gmail.com>
Date: Wed, 20 Jul 2005 14:59:51 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: kernel guide to space
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050711145616.GA22936@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050711145616.GA22936@mellanox.co.il>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/11/05, Michael S. Tsirkin <mst@mellanox.co.il> wrote:
> 
[snip]
> kernel guide to space AKA a boring list of rules
> http://www.mellanox.com/mst/boring.txt
> 
[snip]
> 
> 3c. * in types
>         Leave space between name and * in types.
>         Multiple * dont need additional space between them.
> 
>         struct foo **bar;
> 
Don't put spaces between `*' and the name when declaring variables,
even if it's not a double pointer.   int * foo;  is ugly. Common
convention is  int *foo;

> 3e. sizeof
>         space after the operator
>         sizeof a
> 

I don't think that's a hard rule, there's plenty of code that does 
"sizeof(type)"  and not  "sizeof (type)", and whitespace cleanup
patches I've done that change "sizeof (type)" into "sizeof(type)" have
generally been accepted.

[snip]
> 
> 4. Indentation rules for C
>         Use tabs, not spaces, for indentation. Tabs should be 8 characters wide.
> 
A tab is a tab is a tab, how it's displayed is up to the editor
showing the file.


[snip]
> 
> static struct foo *foo_bar(struct foo *first, struct bar *second,
>                            struct foobar* thirsd);
> 
In this example you are not consistently placing your *'s, "struct foo
*first" vs "struct foobar* thirsd". Common practice is "struct foo
*first".


[snip]
> 
>         No more than one blank line in a row.
>         Last (or first) line in a file is never blank.
> 
Files should end with a  newline. gcc will even warn (with -pedantic)
if this is not so.

"line<nl>
 line"

is wrong,

"line<nl>
 line<nl>
"

is right.


> Non-whitespace issues:
> 
> 6. One-line statement does not need a {} block, so dont put it into one
>         if (foo)
>                 bar;
> 

Not always so, if `bar' is a macro adding {} may be safer. Also
sometimes adding {} improves readability, which is important.


> 7. Comments
>         Dont use C99 // comments.
> 

s/Dont/Don't/


> 9a. Integer types
>         int is the default integer type.
>         Use unsigned type if you perform bit operations (<<,>>,&,|,~).
>         Use unsigned long if you have to fit a pointer into integer.
>         long long is at least 64 bit wide on all platforms.
>         char is for ASCII characters and strings.
>         Use u8,u16,u32,u64 if you need an integer of a specific size.

u8,s8,u16,s16,u32,s32,u64,s64


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
