Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315097AbSDWIC2>; Tue, 23 Apr 2002 04:02:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315102AbSDWIC2>; Tue, 23 Apr 2002 04:02:28 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:60332 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S315097AbSDWIC1>;
	Tue, 23 Apr 2002 04:02:27 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15556.42357.87448.366402@argo.ozlabs.ibm.com>
Date: Tue, 23 Apr 2002 10:06:13 +1000 (EST)
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] TRIVIAL 2.5.8: clean up fs_exec.c
In-Reply-To: <E16zUnQ-00016q-00@wagner.rustcorp.com.au>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell writes:

> -	memcpy(corename,"core.", 5);
> -	corename[4] = '\0';
> +	memcpy(corename,"core", 5); /* include trailing \0 */

What's wrong with strcpy?  gcc3 will even turn it into a memcpy for
you. :)

Paul.
