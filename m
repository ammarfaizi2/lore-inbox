Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261565AbVDESw7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261565AbVDESw7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 14:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261891AbVDESvG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 14:51:06 -0400
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33]:45464 "HELO
	smtp002.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261514AbVDESs6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 14:48:58 -0400
From: Blaisorblade <blaisorblade@yahoo.it>
To: Renate Meijer <kleuske@xs4all.nl>
Subject: Re: [08/08] uml: va_copy fix
Date: Tue, 5 Apr 2005 20:53:19 +0200
User-Agent: KMail/1.7.2
Cc: Greg KH <gregkh@suse.de>, stable@kernel.org, jdike@karaya.com,
       linux-kernel@vger.kernel.org
References: <20050405164539.GA17299@kroah.com> <20050405164815.GI17299@kroah.com> <c8cb775b8f5507cbac1fb17b1028cffc@xs4all.nl>
In-Reply-To: <c8cb775b8f5507cbac1fb17b1028cffc@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504052053.20078.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 05 April 2005 20:47, Renate Meijer wrote:
> On Apr 5, 2005, at 6:48 PM, Greg KH wrote:
> > -stable review patch.  If anyone has any objections, please let us
> > know.
> >
> > ------------------
> >
> > Uses __va_copy instead of va_copy since some old versions of gcc
> > (2.95.4
> > for instance) don't accept va_copy.
>
> Are there many kernels still being built with 2.95.4? It's quite
> antiquated, as far as
> i'm aware.
>
> The use of '__' violates compiler namespace.
Why? The symbol is defined by the compiler itself.
> If 2.95.4 were not easily 
> replaced by
> a much better version (3.3.x? 3.4.x) I would see a reason to disregard
> this, but a fix
> merely to satisfy an obsolete compiler?

Let's not flame, Linus Torvalds said "we support GCC 2.95.3, because the newer 
versions are worse compilers in most cases". One user complained, even 
because he uses Debian, and I cannot do less than make sure that we comply 
with the requirements we have choosen (compiling with that GCC).

Please let's not start a flame on this. Consider me as having no opinion on 
this except not wanting to break on purpose Debian users. If you want, submit 
a patch removing Gcc 2.95.3 from supported versions, and get ready to fight 
for it (and probably loose).

Also, that GCC has discovered some syscall table errors in UML - I sent a 
separate patch, which was a bit big sadly (in the reduced version, about 70 
lines + description).
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade

