Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130750AbQLCAvo>; Sat, 2 Dec 2000 19:51:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130764AbQLCAvf>; Sat, 2 Dec 2000 19:51:35 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:44306 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S130750AbQLCAvV>;
	Sat, 2 Dec 2000 19:51:21 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>
cc: Donald Becker <becker@scyld.com>, linux-kernel@vger.kernel.org,
        netdev@oss.sgi.com
Subject: Re: [RFC] Configuring synchronous interfaces in Linux 
In-Reply-To: Your message of "Sat, 02 Dec 2000 13:07:29 MDT."
             <Pine.LNX.3.96.1001202130202.1450B-100000@mandrakesoft.mandrakesoft.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 03 Dec 2000 11:20:46 +1100
Message-ID: <2776.975802846@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Dec 2000 13:07:29 -0600 (CST), 
Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com> wrote:
>If yes, my guess is correct, I think the proper solution is to:
>* create a generic set_config, which does nothing but convert the calls'
>semantics into ethtool semantics, and
>* add ethtool support to the specific driver

cc list trimmed.

If you go down this path, please add a standard performance monitoring
method to query the current capacity of an interface.  It is frustrating
to report "eth0 is handling 1 Megabyte/second, but we cannot tell if
that is 90% (10BaseT) or 9% (100BaseT) utilization".  We should report
capacity rather than speed because speed alone is not the controlling
factor, other things like half or full duplex affect the capacity.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
