Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262256AbVAIFso@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262256AbVAIFso (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 00:48:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262260AbVAIFso
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 00:48:44 -0500
Received: from rproxy.gmail.com ([64.233.170.201]:59361 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262256AbVAIFsm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 00:48:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=feH7i1/CuevzKjWiJ9aZfcGMQ6HIe1fyMpRnpo6TuukJWKijvOruvEedTQ1igNxmjc5mG1PCgtkgRMpr6O3uTrPhPP8qX8ihJqSA+0SNfaB7IeyEAaA41ONUckz8jX/F+Cayd50lQR7ik4Y+Uc/fL++VC5nCS9CdFXV8PLUac2Q=
Message-ID: <5a4c581d050108214866117e3a@mail.gmail.com>
Date: Sun, 9 Jan 2005 06:48:41 +0100
From: Alessandro Suardi <alessandro.suardi@gmail.com>
Reply-To: Alessandro Suardi <alessandro.suardi@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: CONFIG_SCSI_QLA2<tripleX> looks dead - could it be removed ?
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hoping that this time the gmail filter doesn't bounce my subject (doh)

Said entry only appears in defconfigs, but doesn't seem to be actually
used by anyone - at least according to this grep:

[asuardi@incident linux]$ find . -type f | xargs grep
CONFIG_SCSI_QLA2XXX | grep -v defconfig
./drivers/scsi/Makefile:obj-$(CONFIG_SCSI_QLA2XXX)      += qla2xxx/
./include/linux/autoconf.h:#define CONFIG_SCSI_QLA2XXX_MODULE 1
./.config:CONFIG_SCSI_QLA2XXX=m
./.config.old:CONFIG_SCSI_QLA2XXX=m
[asuardi@incident linux]$

Moreover, there doesn't seem to be any entry in kbuild menus to
 turn it off. Even taking it out of my .config and running oldconfig
 brings it back in.

--alessandro
 
 "And every dream, every, is just a dream after all"
  
    (Heather Nova, "Paper Cup")
