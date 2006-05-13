Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932491AbWEMSZU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932491AbWEMSZU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 14:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932493AbWEMSZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 14:25:19 -0400
Received: from wr-out-0506.google.com ([64.233.184.226]:37260 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932491AbWEMSZR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 14:25:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=O1TCPs3D5yelA3z5p+b5H+c9OpuSFHeYEEvYYIsDwRwHuAkVtP+SX//DzLsQX2O7pJ1w6AoZR1UKTkx0wLHU3Iu1ebykxYUYWeAaVgfJiTgKkVXpwXW8Qsr88yA1F/5shnZ8Dz3dvs7ZuZRhPIqnfyTY6C7vG0oHiQr09lQ+sy4=
Message-ID: <9a8748490605131125l785d20e4p3fc1d8b25346c592@mail.gmail.com>
Date: Sat, 13 May 2006 20:25:13 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH 2.6.17-rc4 5/6] Add kmemleak support for ARM
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060513160618.8848.53189.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060513155757.8848.11980.stgit@localhost.localdomain>
	 <20060513160618.8848.53189.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/13/06, Catalin Marinas <catalin.marinas@gmail.com> wrote:
> From: Catalin Marinas <catalin.marinas@arm.com>
>
> This patch modifies the vmlinux.lds.S script and adds the backtrace support
> for ARM to be used with kmemleak.
>
[snip]
> +static inline unsigned long arch_call_address(void *frame)
> +{
> +       return *(unsigned long *) (frame - 4) - 4;

       return *(unsigned long *)(frame - 4) - 4;


> +}
> +
> +static inline void *arch_prev_frame(void *frame)
> +{
> +       return *(void **) (frame - 12);

       return *(void **)(frame - 12);


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
