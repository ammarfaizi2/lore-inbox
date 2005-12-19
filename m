Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964849AbVLSQnf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964849AbVLSQnf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 11:43:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964850AbVLSQne
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 11:43:34 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:23032 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S964849AbVLSQne
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 11:43:34 -0500
Subject: RE: [PATCH rc5-rt2 2/3] plist: add new implementation
From: Daniel Walker <dwalker@mvista.com>
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Cc: Oleg Nesterov <oleg@tv-sign.ru>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
In-Reply-To: <F989B1573A3A644BAB3920FBECA4D25A05050EF4@orsmsx407>
References: <F989B1573A3A644BAB3920FBECA4D25A05050EF4@orsmsx407>
Content-Type: text/plain
Date: Mon, 19 Dec 2005 08:43:28 -0800
Message-Id: <1135010608.30466.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-12-18 at 14:31 -0800, Perez-Gonzalez, Inaky wrote:
> >From: Oleg Nesterov
> >
> >New implementation. It is smaller, and in my opinion cleaner.
> >User-space test: http://www.tv-sign.ru/oleg/plist.tgz
> >
> >Like hlist, it has different types for head and node: pl_head/pl_node.
> >
> >pl_head does not have ->prio field. This saves sizeof(int), and we
> >don't need to have it in plist_del's parameter list. This is also good
> >for typechecking.
> >
> >Like list_add(), plist_add() does not require initialization on
> pl_node,
> >except ->prio.
> 
> /me suggests adding documentation to the header file succintly
> explaining how it is implemented and a quick usage guide (along
> with (C) info).

I second that. 

Daniel

