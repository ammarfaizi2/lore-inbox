Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262330AbSJDUGX>; Fri, 4 Oct 2002 16:06:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262331AbSJDUGX>; Fri, 4 Oct 2002 16:06:23 -0400
Received: from 62-190-217-49.pdu.pipex.net ([62.190.217.49]:55300 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S262330AbSJDUGW>; Fri, 4 Oct 2002 16:06:22 -0400
Date: Fri, 4 Oct 2002 21:20:26 +0100
From: jbradford@dial.pipex.com
Message-Id: <200210042020.g94KKQX4007896@darkstar.example.net>
To: vojtech@suse.cz
Subject: 2.5.X breaks PS/2 mouse
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One of my 486 laptops has a special port on the side, for a dedicated trackball.  I always assumed that it was electrically identical to the standard PS/2 mouse port, which is also present.

With 2.2.x, (I haven't tried 2.4.x on this machine), both the dedicated trackball and a standard external PS/2 mouse work fine, using /dev/psaux.

With 2.5.40, however, the behavior is as follows:

Booting:

With no pointing devices connected, just the port is detected:
serio: i8042 AUX port at 0x60, 0x64 irq 12

With the dedicated trackball connected, it also gets detected:
input: PS/2 Generic mouse on isa0060/serio1
serio: i8042 AUX port at 0x60, 0x64 irq 12

Same with a PS/2 mouse, it also gets detected:
input: PS/2 Generic mouse on isa0060/serio1
serio: i8042 AUX port at 0x60, 0x64 irq 12

Once booted:

Hot plugging either the dedicated trackball or a PS/2 mouse generates a message on connection:

Just to clarify, I am not trying to use them both at the same time.

X also works with the external PS/2 mouse, but not the dedicated trackball.

Any suggestions?

John.
