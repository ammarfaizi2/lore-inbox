Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313120AbSDSXBS>; Fri, 19 Apr 2002 19:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313116AbSDSXBL>; Fri, 19 Apr 2002 19:01:11 -0400
Received: from pc132.utati.net ([216.143.22.132]:28058 "HELO
	merlin.webofficenow.com") by vger.kernel.org with SMTP
	id <S313120AbSDSWn3>; Fri, 19 Apr 2002 18:43:29 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Christian Schoenebeck <christian.schoenebeck@epost.de>,
        "Trever L. Adams" <tadams-lists@myrealbox.com>
Subject: Re: power off (again)
Date: Fri, 19 Apr 2002 11:52:58 -0400
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020418201220.C6D6247B1@debian.heim.lan> <1019163766.6743.8.camel@aurora> <20020419123026.A802D47B4@debian.heim.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020419230335.6454C755@merlin.webofficenow.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 19 April 2002 08:58 am, Christian Schoenebeck wrote:
> Am Donnerstag, 18. April 2002 23:02 schrieb Trever L. Adams:
> > Just out of curiosity, have you changed your power off scripts to
> > reflect: "halt -p".
>
> Yes, this is not the problem

Just thought I'd give a "me too" response.  The Red Hat 7.2 kernel powers 
down all three systems I've tried it on (a Dell Inspiron 3500 laptop, a 
Toshiba Tecra 8000, and an SIS chipset motherboard).  The 2.4.18 and 2.4.17 
kernels do NOT power down any of those systems (It will spins down the hard 
drive instead, but the system power stays on.  Yes, I'm compiling in the 
right APM support.  I've tried it both with and without the "use APM bios to 
power down" switch.)

The only difference between boots is the kernel.  Haven't had time to really 
look into it, but a quick check of the code didn't reveal any obviously 
cuplable differences between the apm power down functions under the arch 
directory.  It seems like something else in the system state is getting 
twiddled that turns a turn-the-machine-off request into a "reduce power but 
stay on" request that just spins down the hard drive...

Dunno.

Rob

