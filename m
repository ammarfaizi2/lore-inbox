Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261405AbUHaQRV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbUHaQRV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 12:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261474AbUHaQRV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 12:17:21 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:19932 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S261426AbUHaQRM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 12:17:12 -0400
Date: Tue, 31 Aug 2004 18:17:10 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Dipankar Sarma <dipankar@in.ibm.com>,
       Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: RCU callback and scheduling while atomic!
Message-ID: <20040831161710.GA21782@MAIL.13thfloor.at>
Mail-Followup-To: Dipankar Sarma <dipankar@in.ibm.com>,
	Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Dipankar!
Hi Rusty!

just a short question regarding RCU callbacks:

it seems that the RCU callback is not allowed 
to (re-)schedule, as it is done occasionally by 
put_namespace() for example, as I keep getting 
"bad: scheduling while atomic!", when I do so ...

now the question: what is the 'correct' way to
drop a reference to a namespace when freeing up 
a structure from an RCU callback?

TIA,
Herbert

