Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272796AbTHPGhp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 02:37:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272791AbTHPGhp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 02:37:45 -0400
Received: from ns1.triode.net.au ([202.147.124.1]:23775 "EHLO
	iggy.triode.net.au") by vger.kernel.org with ESMTP id S272781AbTHPGhn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 02:37:43 -0400
Message-ID: <3F3DD0FD.9060705@torque.net>
Date: Sat, 16 Aug 2003 16:36:45 +1000
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, es-es, es
MIME-Version: 1.0
To: John Cherry <cherry@osdl.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH] fix parallel builds for aic7xxx
References: <1060906080.4753.92.camel@cherrytest.pdx.osdl.net>
In-Reply-To: <1060906080.4753.92.camel@cherrytest.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While on the subject of aic7xxx Makefiles, they add the
"-Werror" flag to CFLAGS in both lk 2.4.22-rc2 and
lk 2.6.0-test3 .

This flag can be annoying if there is some messiness in
include files somewhere. In my case some mis-applied patches
in the ide headers cause otherwise harmless compiler warning.
That is until my kernel build tries to build the aic7xxx driver.

As a side note drivers/scsi/aic7xxx/Makefile seems to be the only
Makefile in lk 2.4.22-rc2 adding the "-Werror" flag. About a
dozen Makefiles add it in lk 2.6.0-test3 (mainly in the alpha
and sparc64 architecture trees).

Doug Gilbert

