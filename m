Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262532AbUDLFtO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 01:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262606AbUDLFtO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 01:49:14 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:51114
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S262532AbUDLFtN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 01:49:13 -0400
Message-ID: <407A2DAC.3080802@redhat.com>
Date: Sun, 11 Apr 2004 22:48:28 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7b) Gecko/20040409
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Manfred Spraul <manfred@colorfullife.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: message queue limits
X-Enigmail-Version: 0.83.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Something has to change in the way message queues are created.
Currently it is possible for an unprivileged user to exhaust all mq
slots so that only root can create a few more.  Any other unprivileged
user has no change to create anything.

I think it is necessary to create a per-user limit instead of a
system-wide limit.

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
