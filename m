Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932353AbWJ2TUS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932353AbWJ2TUS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 14:20:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932432AbWJ2TUS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 14:20:18 -0500
Received: from smtp009.mail.ukl.yahoo.com ([217.12.11.63]:62049 "HELO
	smtp009.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932353AbWJ2TUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 14:20:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:Subject:Date:To:Cc:Bcc:Message-Id:Content-Type:Content-Transfer-Encoding:User-Agent;
  b=PyZLL9OsE+Gos8Cs4Z9E9kC6Uvffdv6Cclc90Bi1LqR3czDw57RJFhnzDhXbdYvu2+/4fDm6MFh4axQtEVL+z62547AemdzMWeMqSJ8Nswv3QGWDf5KZclnjt4MY4wKuWkcjtVGNeoTE4B6LhdvR4Tqc1jTu5tqKNkBDP995zZE=  ;
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 00/11] UBD driver little cleanups for 2.6.19
Date: Sun, 29 Oct 2006 20:17:23 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Message-Id: <20061029191723.12292.50164.stgit@americanbeauty.home.lan>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Many cleanups for the UBD driver; these are mostly microfixes, I was waiting to
finish and reorder also locking fixes (the code works, it is only to resplit,
reproof-read and changelogs must be written) but I decided to send these ones
for now. The rest will maybe be merged for 2.6.20.

The only locking change is a conversion of a spinlock to a mutex, but it is
correct anyway, and it has been tested (which is enough since it relates
just to the setup/teardown path) with all debugging options active; I did
boot-test and hotplug/hotunplug test.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
