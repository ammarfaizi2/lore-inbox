Return-Path: <linux-kernel-owner+w=401wt.eu-S1751228AbXAIJUy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228AbXAIJUy (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 04:20:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbXAIJUy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 04:20:54 -0500
Received: from smtp-102-tuesday.nerim.net ([62.4.16.102]:2133 "EHLO
	kraid.nerim.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751228AbXAIJUx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 04:20:53 -0500
Date: Tue, 9 Jan 2007 10:20:57 +0100
From: Jean Delvare <khali@linux-fr.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Kai Germaschewski <kai@germaschewski.name>,
       Sam Ravnborg <sam@ravnborg.org>
Subject: .version keeps being updated
Message-Id: <20070109102057.c684cc78.khali@linux-fr.org>
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.8.20; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Since 2.6.20-rc1 or so, running "make" always builds a new kernel with
an incremented version number, whether there has actually been any
change done to the code or configuration or not. This increases the
build time quite a bit.

I've tracked it down to include/linux/compile.h always being updated,
and this is because .version is updated. I couldn't find what is
causing .version to be updated each time though. Can anybody help
there? Was this change made on purpose or is this a bug which we should
fix?

Thanks,
-- 
Jean Delvare
