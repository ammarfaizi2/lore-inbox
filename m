Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129051AbRBNOM4>; Wed, 14 Feb 2001 09:12:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129055AbRBNOMq>; Wed, 14 Feb 2001 09:12:46 -0500
Received: from vega.digitel2002.hu ([213.163.0.181]:29957 "EHLO
	vega.digitel2002.hu") by vger.kernel.org with ESMTP
	id <S129051AbRBNOMh>; Wed, 14 Feb 2001 09:12:37 -0500
Date: Wed, 14 Feb 2001 15:12:29 +0100
From: Gábor Lénárt <lgb@lgb.hu>
To: Ville Herva <vherva@mail.niksula.cs.hut.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: LDT allocated for cloned task!
Message-ID: <20010214151229.A17338@vega.digitel2002.hu>
Reply-To: lgb@lgb.hu
In-Reply-To: <20010213124226.A15600@stormix.com> <E14Sk5t-0002Sl-00@the-village.bc.nu> <20010213104823.A14060@netnation.com> <20010214160649.D11083@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.12i
In-Reply-To: <20010214160649.D11083@niksula.cs.hut.fi>; from vherva@mail.niksula.cs.hut.fi on Wed, Feb 14, 2001 at 04:06:49PM +0200
X-Operating-System: vega Linux 2.2.18 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2001 at 04:06:49PM +0200, Ville Herva wrote:
> > I think I've found what's doing it...xmms with the avi-xmms plugin will
> > cause the message to appear at startup even without playing anything. 
> > Moving the libraries out of the /usr/lib/xmms/Input directory and
> > starting xmms again will not produce any message.  I only just recently
> > downloaded this plugin which is probably why I didn't see it before.
> > 
> > It's also happening on my second (non-DRI) head, so it's probably not
> > related to that (I'll reboot and try again without any DRI modules loaded
> > and see).
> 
> I saw/see a lot of those messages on 2.2.18pre19 as well. I hacked the
> kernel to show the process in question, and it's always xmms:
> 
> LDT allocated for cloned task (pid=20272; count=3)!
> 
> 20272 pts/10   RN   186:01 xmms
> 
> And I do have the xmms-avi plugin in the plugin directory. So if you find a
> bug/fix to 2.4, could you please check 2.2 as well? (I'm afraid I'm not
> nearly clueful enough.) 

xmms-avi uses DLL loader from wine too? I mean does it use windows codecs
to play AVIs? In this case, the dll loader set up some LDT settings and
this casue that message. However with our player - mplayer - it does not
detected my myself (it can use DLLs to play DivX movies, as well).

-- 
 --[ Gábor Lénárt ]---[ Vivendi Telecom Hungary ]---------[ lgb@lgb.hu ]--
 U have 8 bit comp or chip of them and it's unused or to be sold? Call me!
 -------[ +36 30 2270823 ]------> LGB <-----[ Linux/UNIX/8bit 4ever ]-----
