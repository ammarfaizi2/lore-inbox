Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261596AbUKIRn4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261596AbUKIRn4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 12:43:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261598AbUKIRn4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 12:43:56 -0500
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32]:40089 "HELO
	smtp001.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261596AbUKIRnv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 12:43:51 -0500
From: Blaisorblade <blaisorblade_spam@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] Re: 2.6.9-bb1, 2.4.27-bs1, SKAS3/2.6-V7 released
Date: Tue, 9 Nov 2004 12:41:06 +0100
User-Agent: KMail/1.7.1
Cc: Nuutti Kotivuori <naked@iki.fi>, linux-kernel@vger.kernel.org,
       user-mode-linux-user@lists.sourceforge.net
References: <200411041932.39733.blaisorblade_spam@yahoo.it> <871xf4a5kc.fsf@aka.i.naked.iki.fi>
In-Reply-To: <871xf4a5kc.fsf@aka.i.naked.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411091241.06637.blaisorblade_spam@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 08 November 2004 13:28, Nuutti Kotivuori wrote:
> Blaisorblade wrote:
> > Changes in both 2.6.9 and 2.4.27:
> > they run fine on 2.6.9 host kernels, without hanging at the exit.
>
> I want to get this clear:

> Every older guest UML kernel will hang on exit on 2.6.9 hosts from now
> on, and there's nothing to fix it but to update the guest UML patches?

> This is a nasty limitation in general - because it means that on the
> update to 2.6.9, every kernel binary needs to be updated - and finding
> rock solid versions of kernels + UML patches is not a fast process.

Yes, I perfectly agree with you. However, there are, for 2.6, the security 
fixes which are needed.

Well, it is possible that 2.6.10 (or even 2.6.11) will make again old UML 
binaries work. I.e., this is my hope, but no code is ready for this, yet.

In fact, Linus always said "binary compatibility is important".

UML was using a strange undocumented, and unwanted interface, but this is not 
a good reason for the kernel to break it. I think they did not even notice 
that. Also, however, I find that the breakage is a real bug.

The splitout version of the patches is available, and the 
uml-hang-on-2.6.9-host.patch is the one to apply. For 2.4, it cannot be 
applied separately, though (it requires one of the current incrementals, 
which is included in the patchset).

Unfortunately, it does not work on most kernel versions - it can be adapted, 
though, and if I find time, I will.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729

