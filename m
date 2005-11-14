Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751220AbVKNSWl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220AbVKNSWl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 13:22:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751223AbVKNSWk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 13:22:40 -0500
Received: from mail.metronet.co.uk ([213.162.97.75]:35750 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP
	id S1751222AbVKNSWk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 13:22:40 -0500
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Dave Jones <davej@redhat.com>
Subject: Re: [2.6 patch] i386: always use 4k stacks
Date: Mon, 14 Nov 2005 18:22:31 +0000
User-Agent: KMail/1.9
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Alex Davis <alex14641@yahoo.com>,
       linux-kernel@vger.kernel.org
References: <20051114133802.38755.qmail@web50205.mail.yahoo.com> <200511141802.45788.s0348365@sms.ed.ac.uk> <20051114181854.GB3652@redhat.com>
In-Reply-To: <20051114181854.GB3652@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511141822.31315.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 14 November 2005 18:18, Dave Jones wrote:
> On Mon, Nov 14, 2005 at 06:02:45PM +0000, Alistair John Strachan wrote:
>  > On Monday 14 November 2005 14:49, Alan Cox wrote:
>  > > On Llu, 2005-11-14 at 05:38 -0800, Alex Davis wrote:
>  > > > This will break ndiswrapper. Why can't we just leave this in and let
>  > > > people choose?
>  > >
>  > > If we spent our entire lives waiting for people to fix code nothing
>  > > would ever happen. Removing 8K stacks is a good thing to do for many
>  > > reasons. The ndis wrapper people have known it is coming for a long
>  > > time, and if it has a lot of users I'm sure someone in that community
>  > > will take the time to make patches.
>  >
>  > I honestly don't know if this is the case, but is it conceivable that no
>  > patch could be written to resolve this, because the Windows drivers
>  > themselves only respect Windows stack limits (which are presumably still
>  > 8K?).
>
> Windows drivers can actually use more than 8KB. So in some situations,
> you're already screwed.  There are already cases where vendors customer
> service are now telling people "Use ndiswrapper" when people ask about
> Linux support.
>
> If we continue down this path, we'll have no native wireless drivers for
> Linux. The answer is not to complain to linux-kernel for breaking
> ndiswrapper, but complain to the vendors for not releasing specifications
> for native drivers to be written.

I agree, and I was not arguing for or against breaking ndiswrapper. I think 
it's an interesting (and difficult) problem to solve if 4K-stacks gets in.

LWN has a piece on the possible options, but I suppose you could use the 
argument that forcibly breaking ndiswrapper will spur new driver development 
(but if you look at vendors like Broadcom, they have seem consistently 
unwilling to do this).

http://lwn.net/Articles/150580/

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
