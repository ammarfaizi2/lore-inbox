Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262298AbTESBpY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 21:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262299AbTESBpY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 21:45:24 -0400
Received: from sullivan.realtime.net ([205.238.132.76]:35086 "EHLO
	sullivan.realtime.net") by vger.kernel.org with ESMTP
	id S262298AbTESBpX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 21:45:23 -0400
Date: Sun, 18 May 2003 20:35:16 -0500
From: Milton Miller <miltonm@realtime.net>
Message-Id: <200305190135.h4J1ZGR31059@kb5tkf>
To: pavel@ucw.cz
Subject: Re: ioctl32 cleanups: kill code duplication
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> +#include "../../../fs/compat_ioctl.c"

I think the kbuild people would rather you do this in the Makefile with
something like

CFLAGS_ioctl32.o += -Ifs/

and then

#include "compat_ioctl.c"

instead.  I know the seperate source/obj dir people will.

milton

