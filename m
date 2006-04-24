Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750776AbWDXNPd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776AbWDXNPd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 09:15:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778AbWDXNPd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 09:15:33 -0400
Received: from f70.mail.ru ([194.67.57.221]:12047 "EHLO f70.mail.ru")
	by vger.kernel.org with ESMTP id S1750776AbWDXNPd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 09:15:33 -0400
From: Serge Goodenko <s_goodenko@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: Question on using Linux as a router
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: unknown via proxy [217.175.133.182]
Date: Mon, 24 Apr 2006 17:15:31 +0400
Reply-To: Serge Goodenko <s_goodenko@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E1FY0uZ-0002aL-00.s_goodenko-mail-ru@f70.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everybody!

I got the following question.

When I use linux as a router (via ip forwarding) what kernel variables
(maybe some queues?) represent the closest analogue of usual hardware router
input and output buffers? May this be, say, backlog queue or something else?

The things I need to get are the sizes and loads of that buffers during
transmission.
I know about variables such as sk->sk_rcvbuf and sk->sk_rmem_alloc but they
are not used during ip forwarding as the socket (i.e. sock structure) is not
even being created for that purpose. As far as I understood these variables
in sock structure are mostly used for tcp-level packet processing and they
represent the values written in files like /proc/sys/net/core/wmem_default
etc. (please correct me if that's wrong), but nevertheless maybe I also can
use these values for "routing" buffers (i.e. on ip level)?

thanks in advance,
Servge
MIPT
Moscow, Russia

