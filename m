Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261836AbTJMQvY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 12:51:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261838AbTJMQvY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 12:51:24 -0400
Received: from mail4.bluewin.ch ([195.186.4.74]:49300 "EHLO mail4.bluewin.ch")
	by vger.kernel.org with ESMTP id S261836AbTJMQvX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 12:51:23 -0400
Date: Mon, 13 Oct 2003 18:51:04 +0200
From: Roger Luethi <rl@hellgate.ch>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [RFC] State of ru_majflt
Message-ID: <20031013165104.GA14720@k3.hellgate.ch>
Mail-Followup-To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.6.0-test6 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The ru_majflt field of struct rusage doesn't return major page faults --
pages retrieved from cache are counted as well. POSIX and Linux man pages
don't seem to cover that particular field, but the values returned are
neither what BSD (where Linux got its copy of the struct from) does nor
what the field name suggests.

A proper solution would probably have filemap_nopage tell its caller the
correct return code. Is this considered a bug or is it a documentation
issue? How much do we care?

Roger
