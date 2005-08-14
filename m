Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932492AbVHNLfQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932492AbVHNLfQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 07:35:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932493AbVHNLfP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 07:35:15 -0400
Received: from nproxy.gmail.com ([64.233.182.207]:57992 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932492AbVHNLfO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 07:35:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Mpp1xEoRhZwM4tPC2xMZtHgMZghzM2zeF4tpE0HhJS7c2lp2xp7xL2+qJU79MHJp/ZTtPppgjrEz22fSviItmkqCP8/uiwMYLJtTnWNVGTERPHmV76gBoLDr2zeXoDCXJhdjedAsWCZJVkywPwy7IO2Y4aW7dzhykCpwRhqVHIA=
Message-ID: <58cb370e05081404354fe6a097@mail.gmail.com>
Date: Sun, 14 Aug 2005 13:35:11 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: IDE CD problems in 2.6.13rc6
In-Reply-To: <20050813232957.GE3172@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050813232957.GE3172@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On 8/14/05, Dave Jones <davej@redhat.com> wrote:
> I've noticed this week whilst trying to encode a bunch
> of audio CDs to oggs that my boxes running the latest
> kernels are having serious issues, whereas 2.6.12 seems
> to cope just fine.
> 
> The symptoms vary. On some of my machines just inserting
> an audio CD makes the box instantly lock up.
> If I boot with the same CD in the drive, sound-juicer
> can read it just fine. When I get to the next CD, I have
> to reboot again, or it locks up.
> 
> On another box, it gets stuck in a loop where it
> just prints out..
> 
> hdc: irq timeout: status=0xd0 { Busy }    (This line sometimes has status=0xc0)
> ide: failed opcode was: unknown
> 
> The net result is that I've not got a single box that
> will read audio CDs without doing something bad, and I've
> tried it on several quite diverse systems.
> 
> 
> I'll try and narrow down over the next few days when this
> started happening, but IDE / CD folks may have some better
> ideas about which changes were suspicious.

I checked 2.6.13-rc6 patch and I see no IDE / CD changes which
could be responsible for this regression.  You can try reverting ide-cd
changes and see if this helps.  IRQ routing changes?

Bartlomiej
