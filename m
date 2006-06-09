Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965238AbWFILtv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965238AbWFILtv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 07:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965243AbWFILtv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 07:49:51 -0400
Received: from uekaegateway.mam.gov.tr ([193.140.74.2]:994 "EHLO
	uekae.uekae.gov.tr") by vger.kernel.org with ESMTP id S965238AbWFILtu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 07:49:50 -0400
Subject: Discovering select(2) parameters from driver's poll method
From: Ozan Eren Bilgen <oebilgen@uekae.tubitak.gov.tr>
To: Linux e-posta listesi <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: TUBITAK / UEKAE
Date: Fri, 09 Jun 2006 14:50:51 +0300
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20060609114940.01442490169@uekae.uekae.gov.tr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

*** Please CC me your responses ***

Hi,

I am writing a device driver and I have problem with poll method.  For
some reason, I need learn the timeout and descriptor sets of select(2)
call.  Other words to say, if the user space process calls:

	select(n, &readfds, NULL, &exceptionfds, &tv);

With the help of my poll implementation in device driver, I want to
learn that only the write fds is empty.  I am also interested in the
value of timeout parameter.  Please let me know if this is possible.

By the way, I checked out some Linux device drivers, which are
implemented poll method, and related books like LDD.  Everywhere,
poll_wait is called for both read and write queues, without taking the
select(2) call's parameters into account.  For example it still waits
for the read queue although the select call was looking only for write
fds.  My second question is, why a poll method queries all the queues,
instead of querying only the necessary one?


Thank you in advance,

Ozan Eren Bilgen



