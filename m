Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264608AbTFTUda (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 16:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264609AbTFTUda
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 16:33:30 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:34066 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S264608AbTFTUd3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 16:33:29 -0400
Date: Fri, 20 Jun 2003 22:47:29 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Benoit Beauchamp <benoit.beauchamp@sbcglobal.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.72 fixdep / cant make *config
Message-ID: <20030620204729.GA16354@mars.ravnborg.org>
Mail-Followup-To: Benoit Beauchamp <benoit.beauchamp@sbcglobal.net>,
	linux-kernel@vger.kernel.org
References: <000701c33763$7afe1df0$0201a8c0@WIRE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000701c33763$7afe1df0$0201a8c0@WIRE>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 20, 2003 at 12:38:04PM -0700, Benoit Beauchamp wrote:
>   HOSTCC  scripts/fixdep
> In file included from /usr/include/netinet/in.h:212,
>                  from scripts/fixdep.c:107:
> /usr/include/bits/socket.h:305:24: asm/socket.h: No such file or directory
> scripts/fixdep.c: In function `use_config':

What is LANG set to?
Try:
$ echo $LANG

Evantually try:
LANG=C; make

With some installations gcc gets confused, and cannot locate the include files.

	Sam
