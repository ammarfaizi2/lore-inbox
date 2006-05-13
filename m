Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932487AbWEMSYM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932487AbWEMSYM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 14:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932491AbWEMSYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 14:24:12 -0400
Received: from wr-out-0506.google.com ([64.233.184.230]:7052 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932487AbWEMSYL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 14:24:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LmWLPbH63wI2Wa50c3JrTKYoL8TLePUiC7uGVWWbBcJElafVVtMeNfCz4tBuX3UYAG8rCp+DfT+ON1CVEkVdT4m23NUwX8KBnCzLLZ0fp812eXEIalSM655kD64h94FzxBr5avsEKdxO5FqF0HiQxQuEDA878qQ5ijUXd6IDAyo=
Message-ID: <9a8748490605131124i236227a9s3a47a070cfc308a7@mail.gmail.com>
Date: Sat, 13 May 2006 20:24:10 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH 2.6.17-rc4 4/6] Add kmemleak support for i386
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060513160612.8848.95311.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060513155757.8848.11980.stgit@localhost.localdomain>
	 <20060513160612.8848.95311.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/13/06, Catalin Marinas <catalin.marinas@gmail.com> wrote:
> From: Catalin Marinas <catalin.marinas@arm.com>
>
> This patch modifies the vmlinux.lds.S script and adds the backtrace support
> for i386 to be used with kmemleak.
>
[snip]
> +static inline unsigned long arch_call_address(void *frame)
> +{
> +       return *(unsigned long *) (frame + 4);

       return *(unsigned long *)(frame + 4);


> +}
> +
> +static inline void *arch_prev_frame(void *frame)
> +{
> +       return *(void **) frame;

       return *(void **)frame;


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
