Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262239AbUKDOtU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262239AbUKDOtU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 09:49:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262245AbUKDOtU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 09:49:20 -0500
Received: from mail.gmx.net ([213.165.64.20]:42962 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262239AbUKDOtQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 09:49:16 -0500
X-Authenticated: #21910825
Message-ID: <418A415E.40104@gmx.net>
Date: Thu, 04 Nov 2004 15:49:02 +0100
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.6) Gecko/20040114
X-Accept-Language: de, en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: Matt Domsch <Matt_Domsch@dell.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: boot option for CONFIG_EDD_SKIP_MBR?
References: <418A303E.1050709@gmx.net> <20041104134534.GA5360@lists.us.dell.com> <20041104141233.GA32342@redhat.com>
In-Reply-To: <20041104141233.GA32342@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones schrieb:
> On Thu, Nov 04, 2004 at 07:45:34AM -0600, Matt Domsch wrote:
>  > On Thu, Nov 04, 2004 at 02:35:58PM +0100, Carl-Daniel Hailfinger wrote:
>  > > [please CC: me on replies]
>  > > having had problems (inifinte hang on boot) with some Fujitsu
>  > > Siemens Scenic computers when EDD was enabled, I asked myself
>  > > if it would be possible to add a boot option edd=nombr and
>  > > possibly also another boot option edd=off to the EDD code in
>  > > the kernel. These would correspond to CONFIG_EDD_SKIP_MBR
>  > > and CONFIG_EDD, respectively.
>  > >
>  > > Yes, option parsing before entering protected mode is ugly,
>  > > but the vga setup code does it, too.
>  > > 
>  > > What do you think?
>  > 
>  > I'd love it.  I hadn't done it as I thought it would be ugly, and so
>  > far I could blame buggy BIOSes for the delay.  If you want to work up
>  > a patch, I'll gladly review and apply something that does such.
> 
> But would this actually be useful for the cases where EDD has been
> broken so far ? AFAIR, the bootparam parsing happens /after/
> we do the 16-bit EDD asm foo.

AFAIR the VGA setup code does its bootparam parsing by hand because it
suffers from the same problem.

Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/
