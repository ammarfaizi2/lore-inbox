Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288344AbSANAB4>; Sun, 13 Jan 2002 19:01:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288338AbSANABr>; Sun, 13 Jan 2002 19:01:47 -0500
Received: from smtp.kolej.mff.cuni.cz ([195.113.25.225]:37646 "EHLO
	smtp.kolej.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S288334AbSANABg> convert rfc822-to-8bit; Sun, 13 Jan 2002 19:01:36 -0500
X-Envelope-From: martin.macok@underground.cz
Date: Mon, 14 Jan 2002 01:01:34 +0100
From: =?iso-8859-2?Q?Martin_Ma=E8ok?= <martin.macok@underground.cz>
To: linux-kernel@vger.kernel.org
Subject: Re: low latency versus sched O(1) - and versus preempt
Message-ID: <20020114010134.D1399@sarah.kolej.mff.cuni.cz>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20020111131252.A1366@sarah.kolej.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020111131252.A1366@sarah.kolej.mff.cuni.cz>; from martin.macok@underground.cz on Fri, Jan 11, 2002 at 01:12:52PM +0100
X-Echelon: GRU NSA GCHQ CIA Pentagon nuclear conspiration war teror anthrax
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2002 at 01:12:52PM +0100, Martin Maèok wrote:
> I have tested Andrew Morton's low latency patch versus Ingo's sched
> O(1) patch a bit:
> 
> "O1" is 2.4.18-pre2 + sched-O1-2.4.17-G1
> 
> "LL" is 2.4.18-pre3 + 2.4.17-low-latency + riel's 2.4.3ac4-largenice

"PS" is 2.4.18-pre3 + sched H6 + preempt

With PS I got somewhere in between O1 and LL, which means that desktop
performance under load with "nice -n +19 make bzimage" (audiovisual
xmms plugins, tuxracer, Q3A, mozilla) were best smooth with LL, and a
little worse with PS.

With "nice -n 0 make bzimage" desktop interactivity was best with PS,
a little worse with O1 and worst with LL.

If I get enough free time, I will test O1+preempt versus O1+mini-ll.
Something tells me that best results will be with O1+LL, because in LL
versus preempt, LL wins for me (interactivity, smoothness).

-- 
         Martin Maèok                 http://underground.cz/
   martin.macok@underground.cz        http://Xtrmntr.org/ORBman/
