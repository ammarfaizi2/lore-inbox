Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310598AbSCSKXZ>; Tue, 19 Mar 2002 05:23:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310602AbSCSKXQ>; Tue, 19 Mar 2002 05:23:16 -0500
Received: from mailhub.unibe.ch ([130.92.9.52]:52418 "EHLO mailhub.unibe.ch")
	by vger.kernel.org with ESMTP id <S310598AbSCSKXG>;
	Tue, 19 Mar 2002 05:23:06 -0500
Date: Tue, 19 Mar 2002 11:23:02 +0100 (MET)
From: Matthias Scheidegger <mscheid@iam.unibe.ch>
Subject: extending callbacks?
X-X-Sender: mscheid@speedy
To: linux-kernel@vger.kernel.org
Message-id: <Pine.GSO.4.44.0203191111320.20995-100000@speedy>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've got the following problem: I want to register a callback in a kernel
structure, but I need to supply an additional argument to my own code. I.e. I
need a callback

int (*cb)(int u)

to really call

int (*real_cb)(int u, void* my_arg)

At the moment, I'm only focussing on the i386 architecture.
In user space, I'd do this by generating some machine code, which takes the
original args, pushes my_fixed_arg and calls real_cb (using mprotect to make
the generated code callable). That way I'd use a function

int (*)(int) create_callback(int (*real_cb)(int, void*), void *arg);

Is there a good way to do that in the kernel?
Not necessarily using self modifying code, I'll only use it if I must.

Please CC answers to my address, I'm not subscribed.

thanks very much,

Matthias


| Matthias Scheidegger   Institute of Computer Science and Applied Mathematics |
| University of Bern     Neubrueckstr. 10, CH-3012 Bern, Switzerland	       |
| http://www.iam.unibe.ch/~mscheid  Phone: +41 31-6318692  Fax: +41 31-6313261 |

