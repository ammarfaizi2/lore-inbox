Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262482AbSJ2XjZ>; Tue, 29 Oct 2002 18:39:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262486AbSJ2XjZ>; Tue, 29 Oct 2002 18:39:25 -0500
Received: from hera.cwi.nl ([192.16.191.8]:45218 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S262482AbSJ2XjX>;
	Tue, 29 Oct 2002 18:39:23 -0500
From: Andries.Brouwer@cwi.nl
Date: Wed, 30 Oct 2002 00:45:43 +0100 (MET)
Message-Id: <UTC200210292345.g9TNjhA16905.aeb@smtp.cwi.nl>
To: linux-kernel@vger.kernel.org, vojtech@suse.cz
Subject: psmouse.c: Lost synchronization
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vojtech,

I changed my mind a bit.
Yesterday I wrote

> ... the conclusion is that in reality sync was never lost.

and probably that was also true, at least the system log suggested this.
Yesterday I got half a dozen bursts of pairs of "sync lost" during e2fsck.

Today, with 5*HZ instead of HZ/20 I still got a "sync lost" once -
throwing 2 bytes away. So, sync was really lost.
(Again during e2fsck - 2.5.44 crashes when I invoke yast, an ide-scsi
problem, and I tend to forget this.)

This means that I no longer have an opinion about the appropriate
time interval here. Made it 1*HZ for myself for the time being.

Andries
