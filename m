Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262523AbSJLAa4>; Fri, 11 Oct 2002 20:30:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262524AbSJLAa4>; Fri, 11 Oct 2002 20:30:56 -0400
Received: from smtp09.iddeo.es ([62.81.186.19]:21897 "EHLO smtp09.retemail.es")
	by vger.kernel.org with ESMTP id <S262523AbSJLAaz>;
	Fri, 11 Oct 2002 20:30:55 -0400
Date: Sat, 12 Oct 2002 02:36:42 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Andrea Arcangeli <andrea@suse.de>
Cc: "J.A. Magallon" <jamagallon@able.es>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.20pre10aa1
Message-ID: <20021012003642.GG2704@werewolf.able.es>
References: <20021010230945.GB1251@dualathlon.random> <20021011222830.GA1645@werewolf.able.es> <20021011224237.GQ24468@dualathlon.random> <20021011225228.GE1645@werewolf.able.es> <20021011232539.GR24468@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20021011232539.GR24468@dualathlon.random>; from andrea@suse.de on Sat, Oct 12, 2002 at 01:25:39 +0200
X-Mailer: Balsa 1.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.10.12 Andrea Arcangeli wrote:
[...]
>> >
>> >why would you want to remove the list_t declaration? I don't see it.
>> >list_t is just like task_t for struct task_struct etc...
>> >
>> 
>> [..] The main
>> argument was that you can't pre-declare a task_t, but you can
>> with a struct task_t.
>
>so you want to remove task_t too? If yes just grep -v typedef all over
>the tree, and at least it'll be a somehow more coherent decsion ;).
>It's not that list_t forbids you to use struct list_head for
>predeclarations.
>

There is something I do not understand:

struct tst {
	struct x_t	*x;
}

does not need any predeclaraion, tested with gcc -Wall, 2.96, 3.0.4, 3.2.

struct tst {
	x_t	*x;
}

needs it, but you can predeclare a

typedef struct x_t x_t;

if do not want the full include. So I really do not know why everybody
agreed on removing it.

???

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.20-pre10-jam1 (gcc 3.2 (Mandrake Linux 9.0 3.2-2mdk))
