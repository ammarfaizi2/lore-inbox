Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262913AbSJAWqF>; Tue, 1 Oct 2002 18:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262916AbSJAWqF>; Tue, 1 Oct 2002 18:46:05 -0400
Received: from jalon.able.es ([212.97.163.2]:12235 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S262913AbSJAWqE>;
	Tue, 1 Oct 2002 18:46:04 -0400
Date: Wed, 2 Oct 2002 00:51:25 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: bad function ptrs - is it dangerous ?
Message-ID: <20021001225125.GD3927@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi al...

I have a little question. Let's suppose you have this:

int (*pf)(data *);
int f(data*);

so you can:

pf = f;
pf(data).

Fine. But what happens if:

void (*pf)(data *);
int f(data*);

pf = f; // gcc happily swallows, gcc-3.2 gives a warning.
pf(data).

??

In C calling convention, the callee kills the stack so nothing should
happen... or it should ?

The (in)famous graphics driver all you know is doing this with the
copy_info op for gart...

TIA

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.0 (dolphin) for i586
Linux 2.4.20-pre8-jam1 (gcc 3.2 (Mandrake Linux 9.0 3.2-1mdk))
