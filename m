Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269317AbUIHT1m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269317AbUIHT1m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 15:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269312AbUIHT1k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 15:27:40 -0400
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:11991 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S269315AbUIHT1V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 15:27:21 -0400
From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [patch][0/9] ide: sanitize PIO code
Date: Wed, 8 Sep 2004 21:26:24 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200409082126.24556.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

This patchkit:

- converts PIO code to use scatterlists instead of directly walking bios
- fixes longstanding 'data integrity on error' issue in non-taskfile PIO code
- unifies single/multiple PIO handling
- unifies taskfile/non-taskfile PIO handling
- removes bio walking code

Bartlomiej
