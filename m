Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262528AbSJLAhY>; Fri, 11 Oct 2002 20:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262538AbSJLAhY>; Fri, 11 Oct 2002 20:37:24 -0400
Received: from smtp09.iddeo.es ([62.81.186.19]:5002 "EHLO smtp09.retemail.es")
	by vger.kernel.org with ESMTP id <S262528AbSJLAhW>;
	Fri, 11 Oct 2002 20:37:22 -0400
Date: Sat, 12 Oct 2002 02:43:09 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.20pre10aa1
Message-ID: <20021012004309.GI2704@werewolf.able.es>
References: <20021010230945.GB1251@dualathlon.random> <20021011222830.GA1645@werewolf.able.es> <20021011224237.GQ24468@dualathlon.random> <20021011225228.GE1645@werewolf.able.es> <20021011232539.GR24468@dualathlon.random> <20021012003642.GG2704@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20021012003642.GG2704@werewolf.able.es>; from jamagallon@able.es on Sat, Oct 12, 2002 at 02:36:42 +0200
X-Mailer: Balsa 1.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.10.12 J.A. Magallon wrote:
>
>On 2002.10.12 Andrea Arcangeli wrote:
>[...]
>
>There is something I do not understand:
>
>struct tst {
>	struct x_t	*x;
>}
>

Oops,

void f(struct t_t *a)
{
}

needs it, but this works:

typedef struct t_t t_t;

void f(struct t_t *a)
{
}

struct test {
        struct t_t *a;
        t_t *b;
};

gcc is happy.
So all what is needed is to change

struct t_t;

to

typdef struct t_t t_t;


-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.20-pre10-jam1 (gcc 3.2 (Mandrake Linux 9.0 3.2-2mdk))
