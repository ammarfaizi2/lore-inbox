Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263235AbTDVRFz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 13:05:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263243AbTDVRFz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 13:05:55 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:5892
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S263235AbTDVRFy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 13:05:54 -0400
Subject: Re: kernel ring buffer accessible by users
From: Robert Love <rml@tech9.net>
To: Julien Oster <frodo@dereference.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <frodoid.frodo.87wuhmh5ab.fsf@usenet.frodoid.org>
References: <frodoid.frodo.87wuhmh5ab.fsf@usenet.frodoid.org>
Content-Type: text/plain
Message-Id: <1051031876.707.804.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.2 (1.3.2-1) (Preview Release)
Date: 22 Apr 2003 13:17:57 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-04-22 at 12:21, Julien Oster wrote:

> My question now is: Why? I often saw things in the kernel ring buffer
> which I don't want every user to know (e.g. some telephone numbers with
> ISDN).

I think the problem is that kernel messages should not contain private
information, like ISDN phone numbers.  Why is that even in the kernel?

Are you sure its not in /var/log/messages?  The system log contains more
than just dmesg output.  If it is just syslog stuff, just set
/var/log/messages to 0600.

If it is actually coming from the kernel, I would fix the code that is
printed such private information.

	Robert Love

