Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130861AbRAaLqC>; Wed, 31 Jan 2001 06:46:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130886AbRAaLpw>; Wed, 31 Jan 2001 06:45:52 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:26896 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S130861AbRAaLpg>;
	Wed, 31 Jan 2001 06:45:36 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Neale Banks <neale@lowendale.com.au>
cc: Stephen Rothwell <sfr@linuxcare.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.2.18: apm initialised before dmi_scan? 
In-Reply-To: Your message of "Wed, 31 Jan 2001 22:54:22 +1100."
             <Pine.LNX.4.05.10101312249450.16611-100000@marina.lowendale.com.au> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 31 Jan 2001 22:45:29 +1100
Message-ID: <2743.980941529@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jan 2001 22:54:22 +1100 (EST), 
Neale Banks <neale@lowendale.com.au> wrote:
>If this is a correct and justifiable fix for 2.2 then in 2.4 should
>dmi_scan.o be included in export-objs?  Or is there a "better" way of
>doing this?

It should already be correct in 2.4.  In 2.2 the OX_OBJS list is
independent from the O_OBJS list and OX_OBJS is linked first, causing
strange out of order problems.  In 2.4 export-objs is a subset of the
object list and export-objs does not impose any link ordering.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
