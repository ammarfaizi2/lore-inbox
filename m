Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316657AbSE1Opr>; Tue, 28 May 2002 10:45:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316666AbSE1Opq>; Tue, 28 May 2002 10:45:46 -0400
Received: from [209.237.59.50] ([209.237.59.50]:35884 "EHLO
	zinfandel.topspincom.com") by vger.kernel.org with ESMTP
	id <S316657AbSE1Opo>; Tue, 28 May 2002 10:45:44 -0400
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
        Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] PentiumPro/II split in x86 config
In-Reply-To: <3937.1022552654@kao2.melbourne.sgi.com>
	<buo3cwdf0b0.fsf@mcspd15.ucom.lsi.nec.co.jp>
	<20020528030200.GL20729@conectiva.com.br>
	<20020528140322.GA6320@werewolf.able.es>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 28 May 2002 07:45:39 -0700
Message-ID: <524rgse3fw.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "J" == J A Magallon <J.A.> writes:

    J> Problem is that named initializers '.xx =' are ISO C99, so
    J> problably they are not supported in gcc till 3.0...the old way
    J> is working with older compilers.

I actually tried it :).  gcc 2.95 supports named initializers as well:

$ cat a.c
struct foo {
  int x;
  int y;
};

struct foo bar = {
  .y = 2,
  .x = 1
};

int main() {
  printf("%d\n", bar.x);
  return 0;
}

$ gcc a.c
$ ./a.out
1
$ gcc --version
2.95.2

Best,
 Roland
