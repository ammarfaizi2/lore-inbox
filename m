Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269136AbUJQORX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269136AbUJQORX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 10:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269142AbUJQORW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 10:17:22 -0400
Received: from rproxy.gmail.com ([64.233.170.203]:52207 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269136AbUJQORK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 10:17:10 -0400
DomainKey-Signature: a=rsa-sha1; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=fZvIpU/xRTzsyn+Au4EW5qamd3KfsIV/R0ig5ZRIMB6vjnWXkpw+DKyKi3YFFgYlwHBMcyI8SUAKcpCYmQWND2w6mvl1sbTOqTh3Q4dOTb1AuQIRXly0XUU0KMU1HbXdbwe3SSHgwt9r0DxhwRsoYGNPPOqnBHTtvyOBF1kLJt4
Message-ID: <5d6b657504101707175aab0fcb@mail.gmail.com>
Date: Sun, 17 Oct 2004 16:17:06 +0200
From: Buddy Lucas <buddy.lucas@gmail.com>
Reply-To: Buddy Lucas <buddy.lucas@gmail.com>
To: Lars Marowsky-Bree <lmb@suse.de>
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
Cc: David Schwartz <davids@webmaster.com>,
       "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20041017133537.GL7468@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20041016062512.GA17971@mark.mielke.cc>
	 <MDEHLPKNGKAHNMBLJOLKMEONPAAA.davids@webmaster.com>
	 <20041017133537.GL7468@marowsky-bree.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Oct 2004 15:35:37 +0200, Lars Marowsky-Bree <lmb@suse.de> wrote:
> On 2004-10-16T17:28:24, David Schwartz <davids@webmaster.com> wrote:
> 
> > The kernel elects to drop the packet on the call to 'recvmsg'. This is its
> > right -- it can drop a UDP packet at any time. POSIX is careful not to imply
> > that 'select' guarantees future behavior because this is not possible in
> > principle.
> 
> I'm sorry, but according to my reading of POSIX and the Austin spec,
> this is exactly what select() returning 'ready to read' implies.
> 
> The SuV spec is actually quite detailed about the options here:
> 
>         A descriptor shall be considered ready for reading when a call
>         to an input function with O_NONBLOCK clear would not block,
>         whether or not the function would transfer data successfully.
>         (The function might return data, an end-of-file indication, or
>         an error other than one indicating that it is blocked, and in
>         each of these cases the descriptor shall be considered ready for
>         reading.)

But it says nowhere that the select()/recvmsg() operation is atomic, right?


Cheers,
Buddy
