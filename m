Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271846AbTGYAna (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 20:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271847AbTGYAna
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 20:43:30 -0400
Received: from aneto.able.es ([212.97.163.22]:36835 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S271846AbTGYAn0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 20:43:26 -0400
Date: Fri, 25 Jul 2003 02:58:34 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCHSET] Linux 2.4.22-pre8-jam1m
Message-ID: <20030725005834.GC2681@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 2.0.12
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all...

Here is a version of -jam just on top of mainline, instead of -aa
( jam1_m_), as bproc does not mix well with -aa. This works with bproc,
out cluster runs it now...
Anyways, vm behaviour in mainline should be far better now than time ago.
When I have the time will put again all this on top of -aa.

Novelties:

- 17-dcache-fastwalk.bz2: reduce cache bouncing while traversing paths
  already in cache. Hanna Linder <hannal@us.ibm.com>

- 19-struct_thread-pad.bz2: reorder thread info struct to kill some holes
  and reduce its size. Albert Cahalan <albert@users.sf.net>

- 34-zlib-1.1.4.bz2: zlib update and cleanup

- 50-perfctr-2.5.6-pre2.bz2: performance counter update.

- 70-i2c-2.8.0.bz2, 71-i2c-2.8.0-kbuild.bz2, 72-i2c-2.8.0-drivers.bz2,
  75-lm_sensors-2.8.0.bz2: I2C+SENSORS update to 2.8.0.
  It also includes the changes to build systems and in-kernel drivers that
  use i2c (taken from http://www.ensicaen.ismra.fr/~delvare/devel/i2c/)

- 80-bproc-3.2.5-2.bz2, updated patch that could resolve some rare race.

An the usual bug-fixes, cleanups and features: O_STREAMING, -march adds,
PII split, fence ops for barriers in modern processors, CONFIG_NR_CPUS,
ext3-update-orlov-htree.

Get it at:

http://giga.cps.unizar.es/~magallon/linux/kernel/2.4.22-pre8-jam1m.tar.gz

Enjoy !!
(and benchmark, perhaps everything is useless.... ;))

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.22-pre8-jam1m (gcc 3.3.1 (Mandrake Linux 9.2 3.3.1-0.6mdk))
