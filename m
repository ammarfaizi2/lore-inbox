Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131307AbRDSQbx>; Thu, 19 Apr 2001 12:31:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131246AbRDSQbo>; Thu, 19 Apr 2001 12:31:44 -0400
Received: from ncc1701.cistron.net ([195.64.68.38]:61196 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id <S131289AbRDSQbe>; Thu, 19 Apr 2001 12:31:34 -0400
From: wichert@cistron.nl (Wichert Akkerman)
Subject: Re: Children first in fork
Date: 19 Apr 2001 18:31:23 +0200
Organization: Cistron Internet Services
Message-ID: <9bn3sr$fer$1@picard.cistron.nl>
In-Reply-To: <20010419133538.A28654@quatramaran.ens.fr> <NCBBLIEPOCNJOAEKBEAKAEEJOHAA.davids@webmaster.com> <200104191256.OAA31141@quatramaran.ens.fr>
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200104191256.OAA31141@quatramaran.ens.fr>,
=?ISO-8859-1?Q?=C9ric?= Brunet  <ebrunet@quatramaran.ens.fr> wrote:
>Yes, or a clone option (using ptrace, I can always change on the fly=20
>the fork system call into a clone system call and add whatever option I
>want).

Last time I tried that it didn't work since the kernel had already
grabbed the syscall number and the registers so I couldn't change it
anymore.

What you can do is what strace does: insert a loop instruction after
the fork or clone call and remove that when the call returns.

Wichert.


-- 
   ________________________________________________________________
 / Generally uninteresting signature - ignore at your convenience  \
| wichert@cistron.nl                  http://www.liacs.nl/~wichert/ |
| 1024D/2FA3BC2D 576E 100B 518D 2F16 36B0  2805 3CB8 9250 2FA3 BC2D |

