Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932455AbVLRWbs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932455AbVLRWbs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 17:31:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932578AbVLRWbs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 17:31:48 -0500
Received: from fmr18.intel.com ([134.134.136.17]:33688 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S932455AbVLRWbr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 17:31:47 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH rc5-rt2 2/3] plist: add new implementation
Date: Sun, 18 Dec 2005 14:31:26 -0800
Message-ID: <F989B1573A3A644BAB3920FBECA4D25A05050EF4@orsmsx407>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH rc5-rt2 2/3] plist: add new implementation
thread-index: AcYD9MVryrxqRiiJQvqQuQ7TrLBcSwALP9Cw
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "Oleg Nesterov" <oleg@tv-sign.ru>, "Ingo Molnar" <mingo@elte.hu>
Cc: <linux-kernel@vger.kernel.org>, "Steven Rostedt" <rostedt@goodmis.org>,
       "Daniel Walker" <dwalker@mvista.com>
X-OriginalArrivalTime: 18 Dec 2005 22:31:28.0633 (UTC) FILETIME=[C9B83690:01C60422]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Oleg Nesterov
>
>New implementation. It is smaller, and in my opinion cleaner.
>User-space test: http://www.tv-sign.ru/oleg/plist.tgz
>
>Like hlist, it has different types for head and node: pl_head/pl_node.
>
>pl_head does not have ->prio field. This saves sizeof(int), and we
>don't need to have it in plist_del's parameter list. This is also good
>for typechecking.
>
>Like list_add(), plist_add() does not require initialization on
pl_node,
>except ->prio.

/me suggests adding documentation to the header file succintly
explaining how it is implemented and a quick usage guide (along
with (C) info).

-- Inaky 
