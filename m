Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262239AbTFBMLg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 08:11:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262252AbTFBMLg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 08:11:36 -0400
Received: from asclepius.uwa.edu.au ([130.95.128.56]:5081 "EHLO
	asclepius.uwa.edu.au") by vger.kernel.org with ESMTP
	id S262239AbTFBMLd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 08:11:33 -0400
Date: Mon, 2 Jun 2003 20:24:53 +0800 (WST)
From: Paul Marinceu <elixxir@ucc.gu.uwa.edu.au>
To: linux-kernel@vger.kernel.org
Subject: [BUGFIX] 2.5.70 scripts/kconfig/qconf.cc
Message-ID: <Pine.OSF.4.21.0306022017230.92880-100000@morwong.ucc.gu.uwa.edu.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Um, I'm not sure if this has been fixed yet but it's still present in
2.5.70
When running 'make xconfig' this gets spat out:

<snip>
g++ -Wp,-MD,scripts/kconfig/.qconf.o.d -O2  -I/usr/share/qt3/include  -c
-o scripts/kconfig/qconf.o scripts/kconfig/qconf.cc
scripts/kconfig/qconf.cc: In destructor `virtual
ConfigItem::~ConfigItem()':
scripts/kconfig/qconf.cc:291: error: non-lvalue in unary `&'
make[1]: *** [scripts/kconfig/qconf.o] Error 1
make: *** [scripts/kconfig/qconf] Error 2

Line 291 should read as follows:

ConfigItem** ip = (ConfigItem**)&menu->data;

Yes, fairly trivial but I found this in 2.5.69 ;)
Seems no one picked it up yet...hmm

--
 Paul Marinceu
 http://elixxir.ucc.asn.au


