Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264207AbTDJV7I (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 17:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264194AbTDJV7H (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 17:59:07 -0400
Received: from 205-158-62-158.outblaze.com ([205.158.62.158]:58772 "HELO
	spf1.us.outblaze.com") by vger.kernel.org with SMTP id S264192AbTDJV7E (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 17:59:04 -0400
Message-ID: <20030410221040.3631.qmail@email.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Clayton Weaver" <cgweav@email.com>
To: linux-kernel@vger.kernel.org
Date: Thu, 10 Apr 2003 17:10:39 -0500
Subject: Re: [PATCH] new syscall: flink
X-Originating-Ip: 172.174.148.125
X-Originating-Server: ws3-2.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One other thing: why O_CANLINK (suggested flag
to open) instead of O_NOLINK?

It seems to me that for the vast majority of
open()calls, you don't care whether the open
fd can be flink()ed to, because you don't pass
the file descriptor to an untrusted process.

A bit set to eliminate that capability is
the new feature one might need for security reasons with an implemented flink() call
available to programmers.

Seems like leaving "can be linked to" as the default setting and having an explicit flag
to prevent that would be more efficient.

Regards,

Clayton Weaver
<mailto: cgweav@email.com>


-- 
_______________________________________________
Sign-up for your own FREE Personalized E-mail at Mail.com
http://www.mail.com/?sr=signup

