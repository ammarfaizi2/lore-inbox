Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161500AbWJKVUt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161500AbWJKVUt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:20:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161490AbWJKVTh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:19:37 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:28340 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1161368AbWJKVTZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:19:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=pVN51GAwDsZubKWXSQJEdkqBirExgMzJO6a4IZZxPqrP3fpAjBVEVzixYYqfEGb8MZ+OJwQik3t4NrC1WdUr6EbEv6+ETFwtuq8odrP7oDYPW/h/34LyYGDVGYqRPcgc90iuL6WNSGH0aHBPBa+l312PJmQY40CkJ/KoIoGbSFk=
Message-ID: <76ee5f990610111418t459055d8xcdf49d8513af36c0@mail.gmail.com>
Date: Wed, 11 Oct 2006 23:18:50 +0200
From: "Jens Kubieziel" <kubieziel@googlemail.com>
To: linux-kernel@vger.kernel.org
Subject: no OOM-Killer at high RAM and Swapusage
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I recently had a problem with my Sun Fire v40z (24 GB RAM and four
dual core Opterons). This machine runs on a plain 2.6.15 kernel. A
user started Java-processes (java -Xmx 20000m ...). However after some
time I realised that this machine was unresponsive (screen session
didn't respond and no new SSH connection). A htop gave me the
following information:

load: 12.78/11.09/8.25
MEM:  23616/23738MB
Swap: 2000/2000MB
Tasks: 402 total, 17 running

The machine was rebootet because it went unresponsive.

I would normally expect that the OOM-killer start at some point and
kills processes. Obviously this didn't happen here. Could you tell why
this didn't happen? What information could I provide furthermore? What
criteria are there for starting the OOM-killer (links to docs are
appreciated)?

Thanks for any hints
Jens
