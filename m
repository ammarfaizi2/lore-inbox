Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751180AbVIHNvW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbVIHNvW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 09:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751355AbVIHNvW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 09:51:22 -0400
Received: from dizz-a.telos.de ([212.63.141.211]:20875 "EHLO mail.telos.de")
	by vger.kernel.org with ESMTP id S1751180AbVIHNvV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 09:51:21 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: kbuild: libraries and subdirectories
X-MimeOLE: Produced By Microsoft Exchange V6.0.4417.0
Date: Thu, 8 Sep 2005 15:40:59 +0200
Message-ID: <809C13DD6142E74ABE20C65B11A2439809C4C2@www.telos.de>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: kbuild: libraries and subdirectories
Thread-Index: AcW0evKaDLy2oQ1hS6ekvCHHW0qEyA==
From: "Budde, Marco" <budde@telos.de>
To: <linux-kernel@vger.kernel.org>
X-telosmf: done
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a large number of sources files, which I have to
compile into one kernel module. Let's assume I have the
following source organisation:

  main/
    main_code.c
  lib1/
    part1/
      file_1_1_1.c
    part2/
      file_1_2_1.c
  lib2/
    part1/
      file_2_1_1.c
    part2/
      file_2_2_1.c

I would like to build all source files in lib1 into one
lib.a library and all files in lib2 into a second lib.a
library.

At the end I would like to compile the code in main and
link every together (result should be one kernel module).

How can I archieve this with kbuild? Its documentation is not
really deep.

I have added to all subdirectories kbuild files looking like
this:

   lib-m = file_1_1_1.c

This works and creates lib.a archives. In fact I have got
two problems:

 *) How can I tell kbuild in lib1 and lib2 to descend into
    the part directories?

 *) How can I link the libraries of the part directories into
    libs in the lib directories?

cu, Marco

