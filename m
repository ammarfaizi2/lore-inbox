Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261517AbSJ1Vso>; Mon, 28 Oct 2002 16:48:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261527AbSJ1Vsn>; Mon, 28 Oct 2002 16:48:43 -0500
Received: from smtp09.iddeo.es ([62.81.186.19]:65242 "EHLO smtp09.retemail.es")
	by vger.kernel.org with ESMTP id <S261517AbSJ1Vsk>;
	Mon, 28 Oct 2002 16:48:40 -0500
Date: Mon, 28 Oct 2002 22:54:59 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] hyper-threading information in /proc/cpuinfo
Message-ID: <20021028215459.GA2118@werewolf.able.es>
References: <20021026004320.GA1676@werewolf.able.es> <Pine.LNX.4.44L.0210261746520.1697-100000@imladris.surriel.com> <20021028185336.GC1454@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20021028185336.GC1454@vmware.com>; from chrisl@vmware.com on Mon, Oct 28, 2002 at 19:53:36 +0100
X-Mailer: Balsa 1.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.10.28 chrisl@vmware.com wrote:
>Yes, we care about that because vmware see a different CPU number from
>the one reported by the customer. And HT twins cpu is consider 1.3x
>instead of 2x.
>

Perhaps what is really needed is a memory hierarchy in /proc (or elsewhere)
that enumerates its associated processors:

/proc/mem/
         /node0..n
               /main   => processors: 0 1 2 3
               /cache/
                      cache0 => processors: 0 2
                      cache1 => processors: 1 2

As I understand, many times ypu want to put a process in some processor
based on its sharing (or independence) of some memory level (numa local
preference, or hyperthreading)...

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.20-pre11-jam2 (gcc 3.2 (Mandrake Linux 9.0 3.2-2mdk))
