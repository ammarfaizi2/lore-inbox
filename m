Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267268AbRGXJsT>; Tue, 24 Jul 2001 05:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267303AbRGXJsJ>; Tue, 24 Jul 2001 05:48:09 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:41347 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S267268AbRGXJsF>; Tue, 24 Jul 2001 05:48:05 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: ian@labfire.com
Date: Tue, 24 Jul 2001 19:47:58 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15197.17486.529066.317633@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: squashing with knfsd
In-Reply-To: message from Ian Wehrman on Monday July 23
In-Reply-To: <20010723122249.A20863@labfire.com>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Monday July 23, ian@labfire.com wrote:
> hello all,
> i was wondering if someone could confirm that the "all_squash" and "anongid"
> keywords are functional in the 2.4 knfs daemon? i can't seem to get this to
> work... my /etc/exports file looks like this:
> 
> /home bowman(rw,all_squash,anongid=501)
> 
> yet no gid mapping seems to be occuring. actually, no squashing of any sort
> works (not even root_squash'ing to the nobody user). is there some trick to
> this, uid mapping like this even supposed to work with knfsd? 
> any thoughts would be most appreciated.

It certainly should work (though I haven't tried it myself recently).

What makes you think that it doesn't?

Note: this doesn't do bi-directional uid/gid mapping.
The export line you have should mean that all access are performed as
though by uid  "-2" and gid "501".  The uid/gid in "ls" output will
still be whatever it is on the server.

NeilBrown

> 
> thanks in advance,
> ian wehrman
> 
> -- 
> Labfire, Inc.
> Seamless Technical Solutions
> http://labfire.com/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
