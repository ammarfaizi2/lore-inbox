Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314001AbSDQBUG>; Tue, 16 Apr 2002 21:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314002AbSDQBUF>; Tue, 16 Apr 2002 21:20:05 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:58586 "HELO atlrel6.hp.com")
	by vger.kernel.org with SMTP id <S314001AbSDQBUE>;
	Tue, 16 Apr 2002 21:20:04 -0400
Subject: Re: Linux 2.4.19-pre7
In-Reply-To: <20020417001818.GA9379@crrstv.net> "from skidley at Apr 16, 2002
 09:18:18 pm"
To: skidley <skidley@crrstv.net>
Date: Tue, 16 Apr 2002 19:17:58 -0600 (MDT)
Cc: Khalid Aziz <khalid_aziz@hp.com>, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL89 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <E16xe58-0004dt-00@lyra.fc.hp.com>
From: Khalid Aziz <khalid@fc.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It is the SPACEs vs TABs problems. Your mailer or my mailer converted
TABs to SPACEs. Replaces SPACEs with TABs or try the following patch
again.

--
Khalid


--- linux-2.4.19-pre7/include/asm-i386/serial.h	Tue Apr 16 18:52:50 2002
+++ linux-2.4.19-pre7-fixed/include/asm-i386/serial.h	Tue Apr 16 18:55:06 2002
@@ -140,8 +140,8 @@
 #endif
 
 #define SERIAL_PORT_DFNS		\
-	HCDP_SERIAL_PORT_DEFNS		\
 	STD_SERIAL_PORT_DEFNS		\
+	HCDP_SERIAL_PORT_DEFNS		\
 	EXTRA_SERIAL_PORT_DEFNS		\
 	HUB6_SERIAL_PORT_DFNS		\
 	MCA_SERIAL_PORT_DFNS


> On Tue, Apr 16, 2002 at 01:56:15PM -0600, Khalid Aziz wrote:
> > I broke this with a typo in my patch (I inserted a line one line above
> > where I wanted to). Follwing patch will fix the problem.
> > 
> > --
> > Khalid
> > 
> > --- linux-2.4.18-hcdpold/include/asm-i386/serial.h      Tue Apr 16
> > 12:05:27 2002
> > +++ linux-2.4.18-hcdp/include/asm-i386/serial.h Tue Apr 16 12:02:54 2002
> > @@ -140,8 +140,8 @@
> >  #endif
> >  
> >  #define SERIAL_PORT_DFNS               \
> > -       HCDP_SERIAL_PORT_DEFNS          \
> >         STD_SERIAL_PORT_DEFNS           \
> > +       HCDP_SERIAL_PORT_DEFNS          \
> >         EXTRA_SERIAL_PORT_DEFNS         \
> >         HUB6_SERIAL_PORT_DFNS           \
> >         MCA_SERIAL_PORT_DFNS
> > 
> > 
> > 
> > 
> failed against 2.4.19-pre7 here
> -- 
> Chad Young
> Linux User #195191 
> 
