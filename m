Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262821AbVGOARZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262821AbVGOARZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 20:17:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262875AbVGOARY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 20:17:24 -0400
Received: from zproxy.gmail.com ([64.233.162.204]:7613 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262872AbVGOARR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 20:17:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=M06UW75p8kMZxDeEjrc7Sb1MO6T26ZrnZUikf4AhFiovhV/JM2IoZmfbsDEw7ULWszJv8iWVhWPEvdBToK2Zj/nDuXuzdIv3DvmEFkpew+e1k3p/i3fV6gEbJF6/90EVaKvEv9mrCyD7w4YpQ6C1obbLciDqr5/+e168AFAOmQA=
Message-ID: <9a874849050714171767b85ced@mail.gmail.com>
Date: Fri, 15 Jul 2005 02:17:13 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
Cc: Chris Wedgwood <cw@f00f.org>, Andrew Morton <akpm@osdl.org>,
       "Brown, Len" <len.brown@intel.com>, dtor_core@ameritech.net,
       torvalds@osdl.org, vojtech@suse.cz, david.lang@digitalinsight.com,
       davidsen@tmr.com, kernel@kolivas.org, linux-kernel@vger.kernel.org,
       mbligh@mbligh.org, diegocg@gmail.com, azarah@nosferatu.za.org,
       christoph@lameter.com
In-Reply-To: <1121386505.4535.98.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <42D3E852.5060704@mvista.com> <20050713184227.GB2072@ucw.cz>
	 <Pine.LNX.4.58.0507131203300.17536@g5.osdl.org>
	 <1121282025.4435.70.camel@mindpipe>
	 <d120d50005071312322b5d4bff@mail.gmail.com>
	 <1121286258.4435.98.camel@mindpipe>
	 <20050713134857.354e697c.akpm@osdl.org>
	 <20050713211650.GA12127@taniwha.stupidest.org>
	 <9a874849050714170465c979c3@mail.gmail.com>
	 <1121386505.4535.98.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/15/05, Lee Revell <rlrevell@joe-job.com> wrote:
> On Fri, 2005-07-15 at 02:04 +0200, Jesper Juhl wrote:
> > While reading this thread it occoured to me that perhaps what we
> > really want (besides sub HZ timers) might be for the kernel to
> > auto-tune HZ?
> >
> > Would it make sense to introduce a new config option (say
> > CONFIG_HZ_AUTO) that when selected does something like this at boot:
> >
> > if (running_on_a_laptop()) {
> >     set_HZ_to(250);
> > }
> 
> I don't think this will fly because we take a big performance hit by
> calculating HZ at runtime.
> 
Even if we only have to do it once at boot?  The thought was to detect
what type of machine we are booting on, figure out what a good HZ
would be for that type of box, then set that HZ value and treat it as
a constant from that point forward.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
