Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261678AbUJaW4c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261678AbUJaW4c (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 17:56:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261680AbUJaW4b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 17:56:31 -0500
Received: from [193.112.238.6] ([193.112.238.6]:54658 "EHLO caveman.xisl.com")
	by vger.kernel.org with ESMTP id S261678AbUJaW4a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 17:56:30 -0500
From: John M Collins <jmc@xisl.com>
Organization: Xi Software Ltd
To: linux-kernel@vger.kernel.org
Subject: Fchown on unix domain sockets?
Date: Sun, 31 Oct 2004 23:55:00 +0100
User-Agent: KMail/1.6.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200410312255.00621.jmc@xisl.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please CC any reply to jmc AT xisl.com as I'm not subscribed.

I wanted to change the ownership on a unix domain socket in a program (running 
as root) I was writing and I was wondering if "fchown" worked on the socket 
descriptor (after I'd run "bind" of course).

It doesn't, you have to use "chown" on the path name - however "fchown" 
silently does nothing, it doesn't report an error.

I don't mind it not working but I think it should report an error. This is on 
2.6.3 kernel.

I tried it on HP/UX 11 and it gave EINVAL (which the HP manual page doesn't 
document) and on Solaris 9 which likewise silently did nothing.

-- 
John Collins Xi Software Ltd www.xisl.com
