Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263800AbUACStG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 13:49:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263803AbUACStF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 13:49:05 -0500
Received: from p50829256.dip.t-dialin.net ([80.130.146.86]:13060 "EHLO
	Marvin.DL8BCU.ampr.org") by vger.kernel.org with ESMTP
	id S263800AbUACStA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 13:49:00 -0500
Date: Sat, 3 Jan 2004 18:49:04 +0000
From: Thorsten Kranzkowski <dl8bcu@dl8bcu.de>
To: John Goerzen <jgoerzen@complete.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.1rc1 fails to build on Alpha
Message-ID: <20040103184904.A3321@Marvin.DL8BCU.ampr.org>
Reply-To: dl8bcu@dl8bcu.de
Mail-Followup-To: John Goerzen <jgoerzen@complete.org>,
	linux-kernel@vger.kernel.org
References: <slrnbvd1ci.2mp.jgoerzen@christoph.complete.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <slrnbvd1ci.2mp.jgoerzen@christoph.complete.org>; from jgoerzen@complete.org on Sat, Jan 03, 2004 at 09:04:18AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 03, 2004 at 09:04:18AM +0000, John Goerzen wrote:
> I'm building 2.6.1-rc1 on my Alpha and am getting this error:
 
>   LD      init/built-in.o
>   LD      .tmp_vmlinux1
> local symbol 0: discarded in section `.exit.text' from drivers/built-in.o
> local symbol 1: discarded in section `.exit.text' from drivers/built-in.o
> make[1]: *** [.tmp_vmlinux1] Error 1

> # CONFIG_HOTPLUG is not set

I was able to eliminate these with 'Support for hot-pluggable devices'.

>From what I understand there must be hiding some errorneous declaration
somewhere, i.e. a pointer to something that is thrown away at link time.
Didn't find it yet, though :)

Thorsten

-- 
| Thorsten Kranzkowski        Internet: dl8bcu@dl8bcu.de                      |
| Mobile: ++49 170 1876134       Snail: Kiebitzstr. 14, 49324 Melle, Germany  |
| Ampr: dl8bcu@db0lj.#rpl.deu.eu, dl8bcu@marvin.dl8bcu.ampr.org [44.130.8.19] |
