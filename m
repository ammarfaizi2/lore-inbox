Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261748AbTJHTcN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 15:32:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261754AbTJHTcN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 15:32:13 -0400
Received: from dclient217-162-71-11.hispeed.ch ([217.162.71.11]:56492 "EHLO
	steudten.com") by vger.kernel.org with ESMTP id S261748AbTJHTcK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 15:32:10 -0400
Message-ID: <3F846637.5040509@steudten.com>
Date: Wed, 08 Oct 2003 21:32:07 +0200
From: Thomas Steudten <alpha@steudten.com>
Reply-To: alpha@steudten.com
Organization: STEUDTEN ENGINEERING
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: BUG: linux-2.6.0-test6: make -O=/var/tmp/build help
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

Maybe i´m not up-to-date, but i tried out the new 2.6 kernel
with the new -O option and it fails with:
Without the -O option it works. Normally one calls
make help and not make -O.. help, but this fails also,
if the environment variable for -O is set.

--------------------8<-------------------8<--------------
(merlin):/usr/src/linux_dir/kernel2.6/linux-2.6.0-test6
[97]:thomas (2) $ make V=1 O=/var/tmp/build help
make -C /var/tmp/build          \
KBUILD_SRC=/usr/src/linux_dir/kernel2.6/linux-2.6.0-test6       KBUILD_VERBOSE=1        \
KBUILD_CHECK= -f /usr/src/linux_dir/kernel2.6/linux-2.6.0-test6/Makefile help
Cleaning targets:
   clean           - remove most generated files but keep the config
   mrproper        - remove all generated files + config + various backup files

Configuration targets:
selfadd-->pwd
selfadd-->/var/tmp/build
make -f scripts/kconfig/Makefile help
make[2]: scripts/kconfig/Makefile: No such file or directory
make[2]: *** No rule to make target `scripts/kconfig/Makefile'.  Stop.
make[1]: *** [help] Error 2
make: *** [help] Error 2

---
Tom

