Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269290AbUH0Ice@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269290AbUH0Ice (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 04:32:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269222AbUH0I2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 04:28:36 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:17361 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S268215AbUH0IZK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 04:25:10 -0400
X-Comment: AT&T Maillennium special handling code - c
Message-ID: <412EEC66.2070508@namesys.com>
Date: Fri, 27 Aug 2004 01:10:14 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: viro@parcelfarce.linux.theplanet.co.uk
CC: Linus Torvalds <torvalds@osdl.org>, Rik van Riel <riel@redhat.com>,
       Diego Calleja <diegocg@teleline.es>, jamie@shareable.org,
       christophe@saout.de, vda@port.imtp.ilyichevsk.odessa.ua,
       christer@weinigel.se, spam@tnonline.net, akpm@osdl.org,
       wichert@wiggy.net, jra@samba.org, hch@lst.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
References: <Pine.LNX.4.44.0408261607070.27909-100000@chimarrao.boston.redhat.com> <Pine.LNX.4.58.0408261315110.2304@ppc970.osdl.org> <412E69D2.50503@namesys.com> <Pine.LNX.4.58.0408261625180.2304@ppc970.osdl.org> <412E769B.1090508@namesys.com> <20040827020350.GF21964@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20040827020350.GF21964@parcelfarce.linux.theplanet.co.uk>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

viro@parcelfarce.linux.theplanet.co.uk wrote:

>On Thu, Aug 26, 2004 at 04:47:39PM -0700, Hans Reiser wrote:
>
>  
>
>>Sometimes you want the nonlocal effects and sometimes you don't, and by 
>>decomposing streams into smaller primitives we can let users choose as 
>>they want.
>>    
>>
>
>Right.  Now, would you kindly post the detailed technical analysis of your
>wonderful design that handles that stuff safely?  With proof of correctness,
>please.  Since we are expected to take your code and use it as "Uber"
>replacement for the existing one, it surely would not be too much to expect,
>would it?
>
>And no, "we have a nice presentation somewhere on namesys" does not
>qualify.
>
>I apologize for the obvious posting in a thread already full of noise,
>but I would like to make *very* sure that lack of ripping you another
>one does *not* mutate into "no objections from viro" in a lovely thread
>on SlashDot in a week or so.
>
>
>  
>
Over the next 6-18 months, one piece at a time, it will all fall into 
place. 

Reiser4 as it is shipping today, consists of close to the minimal 
functionality necessary to replace reiser3, albeit done according to our 
plugin model, and with vastly higher performance.  The full solution is 
not yet written, wait for it.  I understand why you think deadlocks are 
everything, but avoiding them is only a small, albeit necessary, piece 
of the task.

Thanks though for pointing out issues with unlinking files that have 
been cd'd to.
