Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269385AbRHQBgD>; Thu, 16 Aug 2001 21:36:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269390AbRHQBfz>; Thu, 16 Aug 2001 21:35:55 -0400
Received: from unthought.net ([212.97.129.24]:4746 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S269385AbRHQBfi>;
	Thu, 16 Aug 2001 21:35:38 -0400
Date: Fri, 17 Aug 2001 03:35:51 +0200
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Pavel Machek <pavel@suse.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Bulent Abali <abali@us.ibm.com>,
        "Dirk W. Steinberg" <dws@dirksteinberg.de>,
        Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Swapping for diskless nodes
Message-ID: <20010817033551.A2188@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	Rik van Riel <riel@conectiva.com.br>, Pavel Machek <pavel@suse.cz>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Bulent Abali <abali@us.ibm.com>,
	"Dirk W. Steinberg" <dws@dirksteinberg.de>,
	Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <20010816234639.E755@bug.ucw.cz> <Pine.LNX.4.33L.0108162146120.5646-100000@imladris.rielhome.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.33L.0108162146120.5646-100000@imladris.rielhome.conectiva>; from riel@conectiva.com.br on Thu, Aug 16, 2001 at 09:46:59PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2001 at 09:46:59PM -0300, Rik van Riel wrote:
> On Thu, 16 Aug 2001, Pavel Machek wrote:
> 
> > I'd call that configuration error. If swap-over-nbd works in all but
> > such cases, its okay with me.
> 
> Agreed. I'm very interested in this case too, I guess we
> should start testing swap-over-nbd and trying to fix things
> as we encounter them...

FYI:  The following has been rock solid for the past two days, using the
machine mainly for emacs/LaTeX/konqueror/...   There's fairly heavy swap
traffic, often  25-40 MB swap is used.

joe@rhinehart:~$ free
             total       used       free     shared    buffers     cached
Mem:         38052      37164        888      20616       2864      16968
-/+ buffers/cache:      17332      20720
Swap:        65528      24788      40740
joe@rhinehart:~$ uname -a
Linux rhinehart 2.2.19pre17 #1 Tue Mar 13 22:37:59 EST 2001 i586 unknown
joe@rhinehart:~$ cat /proc/swaps 
Filename                        Type            Size    Used    Priority
/dev/nbd0                       partition       65528   24728   -2
joe@rhinehart:~$

I'm swapping over a 3Com 374TX pcmcia card in a 100Mbit hub (hooked up to a
switch, connected to the nbd-server machine)

No problems so far - but then again, this is not an NFS-booting BGP4 router  ;)

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
