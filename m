Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030458AbWEZHRN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030458AbWEZHRN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 03:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030482AbWEZHRN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 03:17:13 -0400
Received: from nz-out-0102.google.com ([64.233.162.197]:59105 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1030458AbWEZHRM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 03:17:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=rTbxO+3freTPV3s1qVLFcEgXVuxAD3SYGmTJ+TM8XYOSJSuPioP6BlQlmAHRAdcyywpiDAhedgDY3gWaj6MUpAi8A5AfVas2RPMmV3XEea7EBglPeiUbS8SjnIny90irTK5ADeF9CCr7oztZieO5KZj/Myg76Tk9tNQHwYnQ6/A=
Message-ID: <84144f020605260017i4682c409vc4a004d016c31270@mail.gmail.com>
Date: Fri, 26 May 2006 10:17:11 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Paul Drynoff" <pauldrynoff@gmail.com>
Subject: Re: [PATCH] kmalloc man page before 2.6.17
Cc: "Linus Torvalds" <torvalds@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <36e6b2150605260007h1601aa04v31c6c698c6e4d1b9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <36e6b2150605260007h1601aa04v31c6c698c6e4d1b9@mail.gmail.com>
X-Google-Sender-Auth: b406c7ef82b35669
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On 5/26/06, Paul Drynoff <pauldrynoff@gmail.com> wrote:
> Currently I with my colleague dispute about quality of code
> Linux vs other. And he fairly point me that linux kernel even
> have no manual entry for "kmalloc".
>
> So please consider include this or similar patch before 2.6.17.
> With this patch
> scripts/kernel-doc -man -function kmalloc mm/slob.c  | nroff -man | less
> create man page for "kmalloc"

Duplicating the comment in mm/slob.c seems pointless. I think we could
move the comment to include/linux/slab.h from mm/slab.c assuming the
kerneldoc script picks it up from there.

                                                   Pekka
