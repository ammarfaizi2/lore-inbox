Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272797AbTG3HxP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 03:53:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272798AbTG3HxO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 03:53:14 -0400
Received: from vtens.prov-liege.be ([193.190.122.60]:55887 "EHLO
	mesepl.epl.prov-liege.be") by vger.kernel.org with ESMTP
	id S272797AbTG3HxO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 03:53:14 -0400
Message-ID: <D9B4591FDBACD411B01E00508BB33C1B01BF8C95@mesadm.epl.prov-liege.be>
From: "Frederick, Fabian" <Fabian.Frederick@prov-liege.be>
To: "Linux-Kernel (E-mail)" <linux-kernel@vger.kernel.org>
Subject: pid_max ?
Date: Wed, 30 Jul 2003 09:53:12 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	I was looking at pid.c file and can't understand pid_max usage.
It's defined as integer (signed) =PID_MAX_DEFAULT (which is 0x8000 (on old
arch, integer max positive value isn't 32767 ? so 0x8000 -> -32768).

	In alloc_pidmap, 'if (pid>=pid_max)' should be in that case always
true so pid=RESERVED_PIDS which is 300 (?).Why not use pid>PID_MAX_DEFAULT
there and forget the pid_max definition ? and why do we have that '300'
value ?

Regards,
Fabian


