Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262796AbSJEWfh>; Sat, 5 Oct 2002 18:35:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262797AbSJEWfh>; Sat, 5 Oct 2002 18:35:37 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:36359
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S262796AbSJEWfg>; Sat, 5 Oct 2002 18:35:36 -0400
Subject: Re: 2.5.40 - no keyboard
From: Robert Love <rml@tech9.net>
To: sean darcy <seandarcy@hotmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <F134x4FR0rmTIVvLVKi0000fe8b@hotmail.com>
References: <F134x4FR0rmTIVvLVKi0000fe8b@hotmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 05 Oct 2002 18:41:42 -0400
Message-Id: <1033857702.742.4389.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-10-05 at 18:37, sean darcy wrote:

> I've built 2.5.40 on a rh8.0 athlon box.  It boots up OK, but NO keyboard.
> 
> It's  a vanilla MS natural keyboard with a small DIN PS/2 connector - not 
> USB. Works fine with 2.4.19 - even prior 2.5.x's.
> 
> I noticed that xconfig  Input device support grays out 
> CONFIG_KEYBOARD_ATKBD. As a test, I hand edited .config. Still didn't work.

You need to enable serio first.  Something like this:

	CONFIG_SERIO=y
	CONFIG_SERIO_I8042=y
	CONFIG_KEYBOARD_ATKBD=y

should work.

	Robert Love

