Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263258AbTJaMPI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 07:15:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263259AbTJaMPI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 07:15:08 -0500
Received: from ultra12.almamedia.fi ([193.209.83.38]:61378 "EHLO
	ultra12.almamedia.fi") by vger.kernel.org with ESMTP
	id S263258AbTJaMPF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 07:15:05 -0500
Message-ID: <3FA25246.16257890@users.sourceforge.net>
Date: Fri, 31 Oct 2003 14:15:02 +0200
From: Jari Ruusu <jariruusu@users.sourceforge.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.22aa1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: sluskyb@paranoiacs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove useless highmem bounce from loop/cryptoloop
References: <20031030134137.GD12147@fukurou.paranoiacs.org>
			<3FA15506.B9B76A5D@users.sourceforge.net> <20031030133000.6a04febf.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Jari Ruusu <jariruusu@users.sourceforge.net> wrote:
> > Cryptoapi interface is quite broken. Your change extends that breakage to
> > loop transfer interface. Please don't do that.
> 
> Please describe this breakage.

It is broken because it includes kmaps. kmaps may be required evil thing
that is currectly required, but in long term kmaps deserve fate of DOS EMS.
Less interfaces that include that damage, the better. Please don't include
that damage in loop transfer interface.

-- 
Jari Ruusu  1024R/3A220F51 5B 4B F9 BB D3 3F 52 E9  DB 1D EB E3 24 0E A9 DD
