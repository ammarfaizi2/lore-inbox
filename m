Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263733AbREYMkf>; Fri, 25 May 2001 08:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263734AbREYMkO>; Fri, 25 May 2001 08:40:14 -0400
Received: from patan.Sun.COM ([192.18.98.43]:48034 "EHLO patan.sun.com")
	by vger.kernel.org with ESMTP id <S263733AbREYMkE>;
	Fri, 25 May 2001 08:40:04 -0400
Message-ID: <3B0E5352.D5D810F3@Sun.COM>
Date: Fri, 25 May 2001 14:42:58 +0200
From: Julien Laganier <Julien.Laganier@Sun.COM>
Reply-To: Julien.Laganier@Sun.COM
Organization: Sun Microsystems
X-Mailer: Mozilla 4.76C-CCK-MCD Netscape [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

I want to register a new Hook in the netfilter (from kernel 2.4.4)
canvas for IP. The struct
used for register is :

struct nf_hook_ops
{
        struct list_head list;

        /* User fills in from here down. */
        nf_hookfn *hook;
        int pf;
        int hooknum;
        /* Hooks are ordered in ascending priority. */
        int priority;
};

And the hook function is a nf_hookfn, which is a typedef :

typedef unsigned int nf_hookfn(unsigned int hooknum,
                               struct sk_buff **skb,
                               const struct net_device *in,
                               const struct net_device *out,
                               int (*okfn)(struct sk_buff *));

What is the parameter int (*okfn)(struct sk_buff *) which is passed to
the hook ?

Thanx for the answers !!!
