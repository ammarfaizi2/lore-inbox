Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265234AbUFMRN4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265234AbUFMRN4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jun 2004 13:13:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265224AbUFMRNH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jun 2004 13:13:07 -0400
Received: from anchor-post-33.mail.demon.net ([194.217.242.91]:16137 "EHLO
	anchor-post-33.mail.demon.net") by vger.kernel.org with ESMTP
	id S265225AbUFMRMn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jun 2004 13:12:43 -0400
Date: Sun, 13 Jun 2004 18:10:35 +0100
From: Simon Richard Grint <rgrint@compsoc.man.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: Compile failure
Message-ID: <20040613171035.GA455@srg.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all

I have just downloaded the most recent bk snapshot of 2.6.7rc3 and
it fails to compile, instead producing the error:
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
drivers/built-in.o(.text+0xa5c72): In function ci_initialize':
: undefined reference to PSB_WARNING'
make: *** [.tmp_vmlinux1] Error 1

The linking error seems to stem from a newly implemented
packet size check in the ohci_initialize function of 
drivers/ieee1394/ohci1394.c not having defined HPSB_WARNING
before use.

Regards

sr
