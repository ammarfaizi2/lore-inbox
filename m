Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261276AbTJWI6E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 04:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261686AbTJWI6E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 04:58:04 -0400
Received: from web11105.mail.yahoo.com ([216.136.131.152]:27543 "HELO
	web11105.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261276AbTJWI6C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 04:58:02 -0400
Message-ID: <20031023085801.40580.qmail@web11105.mail.yahoo.com>
Date: Thu, 23 Oct 2003 10:58:01 +0200 (CEST)
From: =?iso-8859-1?q?an7?= <an3h0ny@yahoo.fr>
Subject: Useless networking code in 2.4.x ?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

If we have a look at tcp_recv_skb, and
tcp_read_sock(),

we notice that there is a SYN check, and if the flag
is on, we do offset-- (sequence number not
corresponding to real data byte). 

This Syn check is useless, as the function cannot be
called at the beginning of a connection (since we have
not copied_seq filled with the last sequence number of
the last packet passed to the upper layer)

What do you think of that ?


___________________________________________________________
Do You Yahoo!? -- Une adresse @yahoo.fr gratuite et en français !
Yahoo! Mail : http://fr.mail.yahoo.com
