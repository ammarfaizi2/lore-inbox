Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267081AbSLQXPC>; Tue, 17 Dec 2002 18:15:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267029AbSLQXOX>; Tue, 17 Dec 2002 18:14:23 -0500
Received: from jdike.solana.com ([198.99.130.100]:897 "EHLO karaya.com")
	by vger.kernel.org with ESMTP id <S267043AbSLQXNR>;
	Tue, 17 Dec 2002 18:13:17 -0500
Message-Id: <200212172324.gBHNO5V03288@karaya.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] UML device configuration reporting 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 17 Dec 2002 18:24:05 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull
	http://jdike.stearns.org:5000/mconfig-2.5

This update allows the UML device drivers to report their configurations
to the host.

				Jeff

 arch/um/drivers/chan_kern.c     |   66 ++++++++++++++++++++++++++++-
 arch/um/drivers/fd.c            |    6 ++
 arch/um/drivers/line.c          |   91 +++++++++++++++++++++++++++++++++++-----
 arch/um/drivers/mconsole_kern.c |   62 +++++++++++++++++++++++++--
 arch/um/drivers/null.c          |    5 +-
 arch/um/drivers/port_user.c     |    9 +++
 arch/um/drivers/pty.c           |   17 ++++++-
 arch/um/drivers/ssl.c           |   32 +++++++++++++-
 arch/um/drivers/stdio_console.c |   30 ++++++++++++-
 arch/um/drivers/tty.c           |    8 ++-
 arch/um/drivers/ubd_kern.c      |   39 +++++++++++++++++
 arch/um/drivers/xterm.c         |    4 +
 arch/um/include/chan_kern.h     |    3 +
 arch/um/include/chan_user.h     |    3 -
 arch/um/include/line.h          |   11 +++-
 arch/um/include/mconsole_kern.h |   16 ++++++-
 16 files changed, 371 insertions(+), 31 deletions(-)

ChangeSet@1.797.71.1, 2002-11-18 15:57:40-05:00, jdike@uml.karaya.com
  Merged the get_config changes from 2.4.

