Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261284AbVBVVzp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261284AbVBVVzp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 16:55:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261288AbVBVVzp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 16:55:45 -0500
Received: from rproxy.gmail.com ([64.233.170.193]:14632 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261284AbVBVVzk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 16:55:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=Kvh9eSHrO6N7PD5hkeUPu+++HfczDcW7D0ZP505GWFU+uQH0p72k9VvnZ3NRF4PoovOzHuODV40bG76pSdkhQkt4Zt3FZu/VWi3UiUDyEGfIqYX1P8+NTq/1aB5lOaAk+OtLmrsjVzk8cCSGbbVGM35p+XdHfweSSzx6RPK81MY=
Message-ID: <4b325ef050222135529a2584a@mail.gmail.com>
Date: Tue, 22 Feb 2005 16:55:39 -0500
From: "Bob O'Neill" <rmoneill@gmail.com>
Reply-To: "Bob O'Neill" <rmoneill@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: reading the same entropy twice
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I have noticed that it is possible on an SMP box for two processes to
simultaneously read the same entropy out of /dev/urandom.  This
doesn't seem right to me.  I was using the entropy value to generate a
random number to use as a session ID, so occasionally there would be a
collision on session IDs, causing a login failure as session IDs are
required to be unique.  This issue does not appear to be related to
entropy depletion.

Could you provide me with some insight into why this is the case, if
it is intentional?  It seems like it could be addressed with a
spinlock.

Thanks.
-Bob
