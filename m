Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261344AbTINU65 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 16:58:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261386AbTINU65
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 16:58:57 -0400
Received: from li.pghoster.com ([207.44.250.59]:34269 "EHLO li.pghoster.com")
	by vger.kernel.org with ESMTP id S261344AbTINU64 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 16:58:56 -0400
Subject: minor dependency bug, config_SERIO
From: "Michal\\ Adamczak" <pokryfka@artland.com.pl>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Artland
Message-Id: <1063573154.8320.7.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Sun, 14 Sep 2003 22:59:14 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

just wanted to report that linux does not compile if
CONFIG_SERIO is a module

the output is:
//////////////
  LD      .tmp_vmlinux1
drivers/built-in.o(.text+0x696c6): In function `atkbd_interrupt':
: undefined reference to `serio_rescan'
drivers/built-in.o(.text+0x69d93): In function `atkbd_disconnect':
: undefined reference to `serio_close'
drivers/built-in.o(.text+0x69eb2): In function `atkbd_connect':
: undefined reference to `serio_open'
drivers/built-in.o(.text+0x6a044): In function `atkbd_connect':
: undefined reference to `serio_close'
drivers/built-in.o(.init.text+0x5c1b): In function `atkbd_init':
: undefined reference to `serio_register_device'
drivers/built-in.o(.exit.text+0x24b): In function `atkbd_exit':
: undefined reference to `serio_unregister_device
////////////////////
-- 
Michal\ Adamczak <pokryfka@artland.com.pl>

