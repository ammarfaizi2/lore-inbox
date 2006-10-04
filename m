Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750871AbWJDT3Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750871AbWJDT3Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 15:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750860AbWJDT3Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 15:29:16 -0400
Received: from mail.aknet.ru ([82.179.72.26]:65288 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S1750865AbWJDT3P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 15:29:15 -0400
Message-ID: <45240BF0.4050400@aknet.ru>
Date: Wed, 04 Oct 2006 23:30:56 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] remove MNT_NOEXEC check for PROT_EXEC mmaps
References: <4516B721.5070801@redhat.com> <45198395.4050008@aknet.ru> <1159396436.3086.51.camel@laptopd505.fenrus.org> <451E3C0C.10105@aknet.ru> <1159887682.2891.537.camel@laptopd505.fenrus.org> <45229A99.6060703@aknet.ru> <1159899820.2891.542.camel@laptopd505.fenrus.org> <4522AEA1.5060304@aknet.ru> <1159900934.2891.548.camel@laptopd505.fenrus.org> <4522B4F9.8000301@aknet.ru> <20061003210037.GO20982@devserv.devel.redhat.com>
In-Reply-To: <20061003210037.GO20982@devserv.devel.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

David Wagner wrote:
>>/That's obviously possible, but I'd feel safer having/
>>/"noexec" on *every* user-writable partition./
> But why would you "feel" safer?  And why should the Linux kernel care
> about how people "feel"?
I am more wondering why should I answer this,
esp. since you do not even care to CC me.

> What threat, exactly, are you trying to
> defend against?  What's your threat model?
Am I supposed to explain why I want to prevent an
attacker from executing the exploit he happened to
copy to one of the user-writable mounts of mine?

> so you say it is not a library and not a binary.  So what is it that you
> are maping in as executable, and why do you think it is reasonable to
> ask the Linux kernel to allow you to execute it, if it lives on a noexec
> partition?
Quick answer is: because not having the exec permission
(chmod -x file) doesn't prevent you from mapping that
file "noexec", and that's correct, not bug. The more
detailed discussion have already happened, and I'd like
to leave MAP_SHARED aside for a time.
Please tell me how your logic applies to MAP_PRIVATE instead,
because right now MAP_PRIVATE is affected the same way the
MAP_SHARED is.

