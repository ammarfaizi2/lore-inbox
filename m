Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263700AbTETL1U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 07:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263705AbTETL1T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 07:27:19 -0400
Received: from angband.namesys.com ([212.16.7.85]:27776 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S263700AbTETL1T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 07:27:19 -0400
Date: Tue, 20 May 2003 15:40:10 +0400
From: Oleg Drokin <green@namesys.com>
To: linux-kernel@vger.kernel.org
Subject: [2.5] cmdline_read_proc strangeness?
Message-ID: <20030520114010.GA27425@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

    There is a bit of strange code in fs/proc/proc_misc.c::cmdline_read_proc()

        int len;

        len = sprintf(page, "%s\n", saved_command_line);
        len = strlen(page);

    Why do we need the strlen() here? It looks like pure overhead to me.
    Am I missing something obvious?

Bye,
    Oleg
