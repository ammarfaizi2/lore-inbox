Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316145AbSENXZE>; Tue, 14 May 2002 19:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316148AbSENXZD>; Tue, 14 May 2002 19:25:03 -0400
Received: from unthought.net ([212.97.129.24]:63920 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S316145AbSENXZB>;
	Tue, 14 May 2002 19:25:01 -0400
Date: Wed, 15 May 2002 01:25:00 +0200
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: Tony.P.Lee@nokia.com
Cc: alan@lxorguk.ukuu.org.uk, lmb@suse.de, woody@co.intel.com,
        linux-kernel@vger.kernel.org, zaitcev@redhat.com
Subject: Re: InfiniBand BOF @ LSM - topics of interest
Message-ID: <20020515012500.D1444@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	Tony.P.Lee@nokia.com, alan@lxorguk.ukuu.org.uk, lmb@suse.de,
	woody@co.intel.com, linux-kernel@vger.kernel.org,
	zaitcev@redhat.com
In-Reply-To: <4D7B558499107545BB45044C63822DDE3A206D@mvebe001.NOE.Nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2002 at 01:19:13PM -0700, Tony.P.Lee@nokia.com wrote:
...
> 
> I like to see user application such as VNC, SAMBA build directly
> on top of IB API.  I have couple of IB cards that can 
> send 10k 32KBytes message (320MB of data) every ~1 second over 
> 1x link with only <7% CPU usage (single CPU xeon 700MHz).  
> I was very impressed.  
> 
> Go thru the socket layer API would just slow thing down.

Not going thru the socket layer will slow you down even more.  It will require
you to re-write every single performance-requiring application every time some
bloke designs a new network interconnect with a new API.

I'd take a 5% performance loss over re-writing all my code any day.

But why would it be any slower going over the socket API ?  After all, quite a
lot of people have put quite a lot of effort into making that API perform very
well.

> 
> With IB bandwidth faster than standard 32/33MHZ PCI, one might
> run DOOM over VNC over IB on remote computer faster 
> than a normal PC running DOOM locally....

But not until you port DOOM to the API-of-the-day.   Sweet idea though  ;)

> 
> One might create a OS that miror the complete process state
> info (replicate all the modified page) everytime that 
> process is schedule out. 

Latency kills.

Adding tracks to the highway doesn't make it any shorter.

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
