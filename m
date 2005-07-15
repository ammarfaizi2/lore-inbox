Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263100AbVGOBkU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263100AbVGOBkU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 21:40:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263109AbVGOBkU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 21:40:20 -0400
Received: from zproxy.gmail.com ([64.233.162.197]:13801 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263100AbVGOBkF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 21:40:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TQUNhefG3YoI9ZjLgMCvcDBUPtZjYdFsFaaSglImph0GGeUMw2iNF2M38J4OpUc+jvTRZWM0kSjp2/SoG4DA3NtcjSOTedv8lGGX+5AGU98YlUwj9WKtycyAjS7pgtDDPEhAd/i0fv3jTx+tAhUGPtOVW+rUHCqBvim/jD49pPY=
Message-ID: <9a87484905071418404a088ae2@mail.gmail.com>
Date: Fri, 15 Jul 2005 03:40:03 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
Cc: Lee Revell <rlrevell@joe-job.com>, Chris Wedgwood <cw@f00f.org>,
       Andrew Morton <akpm@osdl.org>, "Brown, Len" <len.brown@intel.com>,
       dtor_core@ameritech.net, vojtech@suse.cz, david.lang@digitalinsight.com,
       davidsen@tmr.com, kernel@kolivas.org, linux-kernel@vger.kernel.org,
       mbligh@mbligh.org, diegocg@gmail.com, azarah@nosferatu.za.org,
       christoph@lameter.com
In-Reply-To: <Pine.LNX.4.58.0507141718350.19183@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <42D3E852.5060704@mvista.com>
	 <Pine.LNX.4.58.0507131203300.17536@g5.osdl.org>
	 <1121282025.4435.70.camel@mindpipe>
	 <d120d50005071312322b5d4bff@mail.gmail.com>
	 <1121286258.4435.98.camel@mindpipe>
	 <20050713134857.354e697c.akpm@osdl.org>
	 <20050713211650.GA12127@taniwha.stupidest.org>
	 <9a874849050714170465c979c3@mail.gmail.com>
	 <1121386505.4535.98.camel@mindpipe>
	 <Pine.LNX.4.58.0507141718350.19183@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/15/05, Linus Torvalds <torvalds@osdl.org> wrote:
> 
> 
> On Thu, 14 Jul 2005, Lee Revell wrote:
> >
> > I don't think this will fly because we take a big performance hit by
> > calculating HZ at runtime.
> 
> I think it might be an acceptable solution for a distribution that really
> needed it, since it should be fairly simple. However, it's definitely not
> the right solution.
> 
> HOWEVER. I bet that somebody who really really cares (hint hint) could
> easily make HZ be 1000, and then dynamically tweak the divisor at bootup
> to be either 1000, 250, or 100, and then increment "jiffies" by 1, 4 or
> 10.
> 
[...]
> 
> Really. I dare you guys. First one to send me a tested patch gets a gold
> star.
> 

Testing a patch right now, I'll send it to you as soon as it doesn't
blow up on boot (which it currently does).

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
