Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932073AbVHHOPr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932073AbVHHOPr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 10:15:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932072AbVHHOPr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 10:15:47 -0400
Received: from [81.2.110.250] ([81.2.110.250]:6867 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S932073AbVHHOPr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 10:15:47 -0400
Subject: Re: 2.6 select doesn't notify readablity of /proc/loadavg.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Tanaka Akira <akr@m17n.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <87ll3hszmi.fsf@m17n.org>
References: <87ll3hszmi.fsf@m17n.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 08 Aug 2005 15:42:05 +0100
Message-Id: <1123512125.31229.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes I can duplicate that - it appears that proc_file_operations is
acquiring a poll method from somewhere. All the simple create_proc_read*
files hang on a poll() or select() call.

Alan

