Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132041AbRAFULU>; Sat, 6 Jan 2001 15:11:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132938AbRAFULK>; Sat, 6 Jan 2001 15:11:10 -0500
Received: from c-025.static.AT.KPNQwest.net ([193.154.188.25]:21234 "EHLO
	stefan.sime.com") by vger.kernel.org with ESMTP id <S132041AbRAFUKv>;
	Sat, 6 Jan 2001 15:10:51 -0500
Date: Sat, 6 Jan 2001 21:09:51 +0100
From: Stefan Traby <stefan@hello-penguin.com>
To: David Woodhouse <dwmw2@infradead.org>,
        "Stephen C. Tweedie" <sct@redhat.com>,
        Stefan Traby <stefan@hello-penguin.com>,
        Daniel Phillips <phillips@innominate.de>,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Cc: mason@suse.com
Subject: Re: Journaling: Surviving or allowing unclean shutdown?
Message-ID: <20010106210951.A3143@stefan.sime.com>
Reply-To: Stefan Traby <stefan@hello-penguin.com>
In-Reply-To: <20010104224946.C1290@redhat.com> <Pine.LNX.4.30.0101031253130.6567-100000@springhead.px.uk.com> <Pine.LNX.4.21.0101031325270.1403-100000@duckman.distro.conectiva> <3A5352ED.A263672D@innominate.de> <20010104192104.C2034@redhat.com> <20010104220821.B775@stefan.sime.com> <20010104224946.C1290@redhat.com> <1628.978695936@redhat.com> <20010106205726.A9664@cerebro.laendle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010106205726.A9664@cerebro.laendle>; from pcg@goof.com on Sat, Jan 06, 2001 at 08:57:26PM +0100
Organization: Stefan Traby Services && Consulting
X-Operating-System: Linux 2.4.0-fijiji0 (i686)
X-APM: 100% 400 min
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 06, 2001 at 08:57:26PM +0100, Marc Lehmann wrote:

> reply. Sure, you can do virtual log replays, but for example the reiserfs
> log is currently 32mb. Pinning down that much memory for a virtual log
> reply is not possible on low-memory machines.

Nobody with working brain would read it completely into memory.
One just put the block-# that are in the journal into a hash-table
and read the block out of the journal when it's requested.
Because there may be multiple copies of the same block in the
journal, one should take the newest one that can be found in
the last commited transaction.

IMHO Chris Mason already wrote such code, at least he talked about
it...

-- 

  ciao - 
    Stefan

"     ( cd /lib ; ln -s libBrokenLocale-2.2.so libNiedersachsen.so )     "
    
Stefan Traby                Linux/ia32               fax:  +43-3133-6107-9
Mitterlasznitzstr. 13       Linux/alpha            phone:  +43-3133-6107-2
8302 Nestelbach             Linux/sparc       http://www.hello-penguin.com
Austria                                    mailto://st.traby@opengroup.org
Europe                                   mailto://stefan@hello-penguin.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
