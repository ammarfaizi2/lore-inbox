Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268059AbUIPMpd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268059AbUIPMpd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 08:45:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268000AbUIPMl7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 08:41:59 -0400
Received: from mail.gmx.net ([213.165.64.20]:30683 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S268055AbUIPMie (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 08:38:34 -0400
X-Authenticated: #1725425
Date: Thu, 16 Sep 2004 14:52:17 +0200
From: Marc Ballarin <Ballarin.Marc@gmx.de>
To: cijoml@volny.cz
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: CD-ROM can't be ejected
Message-Id: <20040916145217.13d1abab.Ballarin.Marc@gmx.de>
In-Reply-To: <200409161419.38264.cijoml@volny.cz>
References: <200409160025.35961.cijoml@volny.cz>
	<200409161113.55719.cijoml@volny.cz>
	<20040916102236.GB2300@suse.de>
	<200409161419.38264.cijoml@volny.cz>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Sep 2004 14:19:38 +0200
"Bc. Michal Semler" <cijoml@volny.cz> wrote:

> only thing which access cdrom is cpudynd and it access harddrive too....
> 
> notas:~# fuser /dev/hdc
> /dev/hdc:             8102
> notas:~# ps aux|grep 8102
> root      8102  0.0  0.1  1536  456 ?        SNs  13:49   
> 0:00 /usr/sbin/cpudynd -i 1 -p 0.5 0.9 -l 7 -t 120 -h /dev/hda,/dev/hdc
> 
> nothing more

Well, one user is enough to block. Just remove /dev/hdc from cpudynd's
options. There should be little or no gain by adding your CD-Rom, anyway.

Regards
