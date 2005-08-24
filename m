Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932231AbVHXVPt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932231AbVHXVPt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 17:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932236AbVHXVPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 17:15:49 -0400
Received: from zproxy.gmail.com ([64.233.162.205]:17311 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932231AbVHXVPs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 17:15:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Sgj/5KCrmkxFJXvIAJGYmrP35zyI4ehczhGBY/Jgdtok2CN85vfQ47ObIxDqs5dklL6ylLVeg4de4/aLfzYRs7oygz00gxjPKgdoYe8THMBCNKSi/RoYw2U8NL1OyR92B8lMoTZK+jc9E/aHN5JHRtqDxbW798Eplh0/iExQf8c=
Message-ID: <9a8748490508241415cfa3e9c@mail.gmail.com>
Date: Wed, 24 Aug 2005 23:15:43 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: [PATCH 3/3] exterminate strtok - usr/gen_init_cpio.c
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com
In-Reply-To: <200508242106.j7OL61QK010645@laptop11.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <jesper.juhl@gmail.com> <200508242108.53198.jesper.juhl@gmail.com>
	 <200508242106.j7OL61QK010645@laptop11.inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/05, Horst von Brand <vonbrand@inf.utfsm.cl> wrote:
> Jesper Juhl <jesper.juhl@gmail.com> wrote:
[snip]
> 
> > -             if ('\n' == *type) {
> > +             if (!*type || '\n' == *type) {
> 
> Redundant. If *type == '\n', it is certainly != 0.

Hmm, I added that since if we get past the if above it, then "type"
might be !=NULL, but *type might be, but you are right, it's still
redundant since there's a check below that'll catch it if so.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
