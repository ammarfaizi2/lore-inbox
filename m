Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261687AbVAGWr4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261687AbVAGWr4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 17:47:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261679AbVAGWq5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 17:46:57 -0500
Received: from hermes.domdv.de ([193.102.202.1]:13587 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S261676AbVAGWoh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 17:44:37 -0500
Message-ID: <41DF10BA.6040301@domdv.de>
Date: Fri, 07 Jan 2005 23:44:10 +0100
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Lee Revell <rlrevell@joe-job.com>, paul@linuxaudiosystems.com,
       arjanv@redhat.com, hch@infradead.org, mingo@elte.hu, chrisw@osdl.org,
       alan@lxorguk.ukuu.org.uk, joq@io.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM
References: <200501071620.j07GKrIa018718@localhost.localdomain>	<1105132348.20278.88.camel@krustophenia.net> <20050107134941.11cecbfc.akpm@osdl.org>
In-Reply-To: <20050107134941.11cecbfc.akpm@osdl.org>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Lee Revell <rlrevell@joe-job.com> wrote:
> 
>>Really, I think Linux has owned the server space for so long that some
>>folks on this list are getting hubristic.  Just because you have the
>>best server OS does not mean it's the best at everything.
> 
> 
> nah, the requirement is clearly valid, and longstanding.  We need to
> satisfy it.  It's just a matter of working out the best way.
> 
> Chris Wright <chrisw@osdl.org> wrote:
> 
>>...
>>Last I checked they could be controlled separately in that module.  It
>>has been suggested (by me and others) that one possible solution would
>>be to expand it to be generic for all caps.
> 
> 
> Maybe this is the way?

This could give an advantage for e.g. networked daemons, too. No more 
root privilege necessary for applications just to bind to a privileged 
port which does make life easier (CAP_NET_BIND_SERVICE). Other ideas for 
e.g. CAP_NET_RAW or CAP_SYS_RAWIO come to mind. Using the current 
capabilties in this design as all incuding supersets that can be defined 
more fine grained in a later step I guess should suit others, too. The 
remaining problem would then be the design of an extensible interface 
that is backwards compatible.

-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de
