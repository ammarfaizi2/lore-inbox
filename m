Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265794AbTFSPKO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 11:10:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265796AbTFSPKO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 11:10:14 -0400
Received: from web9605.mail.yahoo.com ([216.136.129.184]:16029 "HELO
	web9605.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265794AbTFSPKJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 11:10:09 -0400
Message-ID: <20030619152407.78468.qmail@web9605.mail.yahoo.com>
Date: Thu, 19 Jun 2003 08:24:07 -0700 (PDT)
From: Steve G <linux_4ever@yahoo.com>
Subject: Unaccepted tcp connections
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This e-mail is offtopic but is related to the networking
code. I am working on an inet daemon that listens for tcp
connections and passes the descriptor returned by listen to
a child program to handle. It turns out that many child
programs error during startup and exit without accepting
the connection (linuxconf is one of them). The daemon that
listens sees the descriptor as readable and starts a new
child. This can loop forever.

The question is how can a parent process reliably determine
that its child has accepted the connection? Also, is it
possible to tell anything about a connection that has
returned from listen but not yet accepted? For instance the
source IP address?

Thanks,
Steve Grubb

__________________________________
Do you Yahoo!?
SBC Yahoo! DSL - Now only $29.95 per month!
http://sbc.yahoo.com
