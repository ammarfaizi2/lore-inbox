Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263287AbTH0K4k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 06:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263277AbTH0K4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 06:56:39 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:40393 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S263287AbTH0K4g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 06:56:36 -0400
X-Sender-Authentication: SMTPafterPOP by <info@euro-tv.de> from 217.64.64.14
Date: Wed, 27 Aug 2003 12:56:33 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Ville Herva <vherva@niksula.hut.fi>
Cc: linux-kernel@vger.kernel.org, tejun@aratech.co.kr
Subject: Re: 2.4.22pre8 hangs too (Re: 2.4.21-jam1 solid hangs)
Message-Id: <20030827125633.45f9a003.skraw@ithnet.com>
In-Reply-To: <20030827101313.GX83336@niksula.cs.hut.fi>
References: <20030729073948.GD204266@niksula.cs.hut.fi>
	<20030730071321.GV150921@niksula.cs.hut.fi>
	<Pine.LNX.4.55L.0307301149550.29648@freak.distro.conectiva>
	<20030730181003.GC204962@niksula.cs.hut.fi>
	<20030827064301.GF150921@niksula.cs.hut.fi>
	<20030827101313.GX83336@niksula.cs.hut.fi>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Aug 2003 13:13:13 +0300
Ville Herva <vherva@niksula.hut.fi> wrote:

> On Wed, Aug 27, 2003 at 11:30:27AM +0200, you [Stephan von Krawczynski]
> wrote:
> > 
> > Hm, did you try a serial console? On my side this was a big step forward.
> 
> Do you mean in your case nothing shown on monitor (I've disabled monitor
> blanking, so that is not it), sysrq key didn't work, nmi watchdog didn't
> trigger but you were still able to get output from serial console? An oops?

I often have X setups, so console output gets _somewhere_ in the background.

> Or, did you use kdb/kgdb in addition to serial console?

No.

> > What does your /proc/interrupts look like compared between 2.2 and 2.4 ?
> 
> I don't have 2.2 output at hand, but the 2.4.21-jam1 output doesn't seem too
> suspicious:

You're right, it looks pretty clean and simple. Possibly the only thing I would
try is moving aic away from int 9 to int 10 or so. Int 9 sometimes interferes
with VGA int routing on broken boxes. But that is unlikely (though simple to
test).

Regards,
Stephan

