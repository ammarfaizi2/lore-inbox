Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261970AbTGAKTC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 06:19:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261989AbTGAKTC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 06:19:02 -0400
Received: from hera.cwi.nl ([192.16.191.8]:57795 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S261970AbTGAKTB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 06:19:01 -0400
From: Andries.Brouwer@cwi.nl
Date: Tue, 1 Jul 2003 12:33:22 +0200 (MEST)
Message-Id: <UTC200307011033.h61AXM108459.aeb@smtp.cwi.nl>
To: linux-kernel@vger.kernel.org
Subject: blind conversion strncpy -> strlcpy is harmful
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I notice that people have been replacing strncpy by strlcpy,
introducing bugs in the process.

It is not true that strlcpy is guaranteed to be better than
strncpy. Indeed, strlcpy cannot handle character arrays that
are not necessarily 0-terminated.
