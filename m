Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132174AbRCVUFR>; Thu, 22 Mar 2001 15:05:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132175AbRCVUE5>; Thu, 22 Mar 2001 15:04:57 -0500
Received: from netel-gw.online.no ([193.215.46.129]:4621 "EHLO
	InterJet.networkgroup.no") by vger.kernel.org with ESMTP
	id <S132174AbRCVUE4>; Thu, 22 Mar 2001 15:04:56 -0500
Message-ID: <3ABA5A9A.7B85B5B9@powertech.no>
Date: Thu, 22 Mar 2001 21:03:38 +0100
From: Geir Thomassen <geirt@powertech.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.19pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Trent Jarvi <trentjarvi@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Serial port latency
In-Reply-To: <Pine.LNX.4.20.0103221219410.3343-100000@linuxtaj.korpivaara.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trent Jarvi wrote:
> 
> Hi,
> 
> I'm not on the kernel list.  I just ran across your email while looking at the
> weekly archive.
> 
> I think you want to enable software flow control.
> 
>         tcgetattr( fd, &ttyset );
>         ttyset.c_iflag |= IXOFF;
>         tcsetattr( fd, TCSANOW, &ttyset );
> 

Just tested it, it didn't change anything. The response from the controller
can contain ^S/^Q, so it would be a bad idea anyway ....

> Someone reported that the Java CommAPI driver at http://www.rxtx.org got
> 150-200ms latency with (9600,N,8,1,XON/XOFF).  Beyond that you may have to
> look at something like the realtime support.  I guess 2 ms is normal on
> win98.

Win98 is the problem I am trying to solve with my program ...

> Since you have the scope hooked up you may look at hardware flow control too.
> 
>         tcgetattr( fd, &ttyset );
>         ttyset.c_cflag |= HARDWARE_FLOW_CONTROL;
>         tcsetattr( fd, TCSANOW, &ttyset );

Do you mean CRTSCTS ? HARDWARE_FLOW_CONTROL is not defined in my header files.
I use CLOCAL, which should make the driver ignore modem control lines.

> Let me know if you find anything out.  I'm the maintainer of rxtx and would
> be interested in documenting this for others.

sure ...

> --
> Trent Jarvi
> TrentJarvi@yahoo.com

Thanks anyway

Geir
