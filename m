Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751287AbWHAPOl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbWHAPOl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 11:14:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751293AbWHAPOl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 11:14:41 -0400
Received: from mail.aknet.ru ([82.179.72.26]:57873 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S1751287AbWHAPOk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 11:14:40 -0400
Message-ID: <44CF6EC4.7070502@aknet.ru>
Date: Tue, 01 Aug 2006 19:09:56 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Jan Beulich <jbeulich@novell.com>
Cc: 76306.1226@compuserve.com, rohitseth@google.com, ak@muc.de, akpm@osdl.org,
       Linux kernel <linux-kernel@vger.kernel.org>,
       Zachary Amsden <zach@vmware.com>
Subject: Re: + espfix-code-cleanup.patch added to -mm tree
References: <200607300016.k6U0GYu4023664@shell0.pdx.osdl.net> <44CE766D.6000705@vmware.com> <44CF474C.9070800@aknet.ru> <44CF755C.76E4.0078.0@novell.com> <44CF672E.9080906@aknet.ru> <44CF84C4.76E4.0078.0@novell.com>
In-Reply-To: <44CF84C4.76E4.0078.0@novell.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Jan Beulich wrote:
> That was me, in order to get the unwind annotations right without
> complicating the code too much. Again, FIXUP_ESPFIX_STACK doesn't
> use any unwind directives so can be used anywhere, including the
> .fixup section UNWIND_ESPFIX_STACK switches to.
Yes, but the new version of FIXUP_ESPFIX_STACK _will_
use the annotations (that was Zach's complain), and therefore
it can't be used in a .fixup, and so the new UNWIND_ESPFIX_STACK
_will not_ use the .fixup, just like it was before your change.
I am not saying that your change was wrong, but now I had to undo
it. Let me know if that makes a problem.

