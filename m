Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265979AbUFOWNj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265979AbUFOWNj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 18:13:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265987AbUFOWNj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 18:13:39 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:33712 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S265979AbUFOWNi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 18:13:38 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       <"Nick Piggin"@ldl.fc.hp.com>, nickpiggin@yahoo.com.au
Subject: 2.4.27-pre5 build broken
Date: Tue, 15 Jun 2004 15:26:06 -0600
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200406151526.06821.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch seems to have broken things in 2.4 BK:

	ChangeSet@1.1450, 2004-06-15 09:15:41-03:00, nickpiggin@yahoo.com.au
	  [PATCH] rwsem race fixes backported from 2.6

The default i386 config doesn't build -- mem_map undeclared, plus
references to put_task_struct(), which isn't defined in 2.4.
