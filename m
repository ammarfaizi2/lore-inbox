Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130442AbQKMFQu>; Mon, 13 Nov 2000 00:16:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130445AbQKMFQk>; Mon, 13 Nov 2000 00:16:40 -0500
Received: from deliverator.sgi.com ([204.94.214.10]:55902 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S130442AbQKMFQ2>; Mon, 13 Nov 2000 00:16:28 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: analog.c MODULE_PARM, attention Vojtech Pavlik
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 13 Nov 2000 16:16:23 +1100
Message-ID: <3423.974092583@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Originally sent to vojtech@suse.cz but that host is not resolving.

drivers/char/joystick/analog.c in 2.4.0-test10 has these lines.

MODULE_PARM(js,"1-16s");

#define ANALOG_PORTS            16

static char *js[ANALOG_PORTS];
static int analog_options[ANALOG_PORTS];

Instead of hard coding 16 in MODULE_PARM, I recommend

#define ANALOG_PORTS            16

static char *js[ANALOG_PORTS];
static int analog_options[ANALOG_PORTS];
MODULE_PARM(js,"1-" __MODULE_STRING(ANALOG_PORTS) "s");

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
