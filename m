Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423373AbWF1PzT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423373AbWF1PzT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 11:55:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423372AbWF1PzT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 11:55:19 -0400
Received: from nz-out-0102.google.com ([64.233.162.203]:54036 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1423373AbWF1PzS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 11:55:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MzuwL48p/PvspY/HNE5expoVXH0HYwX8z2w5PKa1+WoVxinWywsRacX5OphyZKJb2Scypbx/UparIAt2PbR0eY/65HuaRQTZmDLwr14YUAzjJz6OZ5CeiMdE3nVABWSSXtKYmcHyYxW6/zixcbOoXr0Z5GRGO4kCJhJI7ICbONw=
Message-ID: <dba10b900606280855g6d415441y92c46ca83c74a469@mail.gmail.com>
Date: Wed, 28 Jun 2006 10:55:17 -0500
From: "Greg Bledsoe" <greg.bledsoe@gmail.com>
To: "Steven Rostedt" <rostedt@goodmis.org>
Subject: Re: pmap, smap, process memory utilization
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0606280511320.32286@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <dba10b900606271140o64b60c97kecb8177f801ff9f4@mail.gmail.com>
	 <Pine.LNX.4.58.0606280511320.32286@gandalf.stny.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for your reply.

On 6/28/06, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Tue, 27 Jun 2006, Greg Bledsoe wrote:
>
> Even if this did work, it will not equal the free command. Since the
> buffers/cache may mix you up.  Some of the buffers can be allocated to
> files that are also mapped, not to mention, you need to account for
> slabs and memory allocated by drivers.
>
> -- Steve
>

Thank you.  This information is extremely difficult to find without
digging into kernel code, which I certainly wish I had time to do, but
don't, and particulars of how many aspects of memory management happen
seems to be nonexistant.  I would like to document this aspect, at
least, as well as I am able and post somewhere to add to the worlds'
global knowledge pool on this subject, and prevent the lkml from
getting bugged about this anymore.

This leads me to the question though, of how the kernel keeps track of
this information overall to report accurately via free and vmstat.
Does it just keep an overall count on the fly as memory is allocated?
And, getting ahead of myself, if that can be done, is it just
considered too expensive to keep a similar acount for each proccess?
That seems to be what I am hearing in previous lkml discussions.

Also, since it seems virtually impossible to get this data on a
per-process basis, does smap suffer from these same difficulties, as
it seems to calculate this information when asked, and not keep it
from process start time.

Again, thank you for your time.

-- 
   Greg Bledsoe

    ----------
    I owe my success to having listened respectfully to the very best
advice, and going and doing the exact opposite.
    G.K. Chesterton
