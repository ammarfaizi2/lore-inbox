Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265355AbTFFGkW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 02:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265356AbTFFGkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 02:40:22 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:4480 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S265355AbTFFGkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 02:40:22 -0400
Date: Fri, 6 Jun 2003 08:00:58 +0100
From: john@grabjohn.com
Message-Id: <200306060700.h5670w90000501@81-2-122-30.bradfords.org.uk>
To: linux-kernel@vger.kernel.org
Subject: [BugDB] kernel compile fails due to changes in sched.h
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just noticed this new bug report in my bug DB:

http://grabjohn.com/kernelbugdatabase/index.php?action=21&id=59

Kernel compilation with devfs chosen in config fails. The compiler complains that "p_opptr" is not a member of struct task_struct. This is because the names of this family have changed in sched.h. Changing the references in base.c from "p_opptr" to "parent" solves the problem.

John.
