Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266520AbRGFMbk>; Fri, 6 Jul 2001 08:31:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266597AbRGFMba>; Fri, 6 Jul 2001 08:31:30 -0400
Received: from mercury.Sun.COM ([192.9.25.1]:11725 "EHLO mercury.Sun.COM")
	by vger.kernel.org with ESMTP id <S266520AbRGFMbV>;
	Fri, 6 Jul 2001 08:31:21 -0400
Message-ID: <3B45AF97.C01C0ABF@Sun.COM>
Date: Fri, 06 Jul 2001 14:31:19 +0200
From: Julien Laganier <Julien.Laganier@Sun.COM>
Organization: Sun Microsystems
X-Mailer: Mozilla 4.76 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Naveen Kumar Pagidimarri <naveen.pagidimarri@wipro.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Hai
In-Reply-To: <GG1WKM00.84G@vindhya.mail.wipro.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Naveen Kumar Pagidimarri wrote:
> 
> Hai All,
> 
>           I am trying to display the detailes of freeram and ramfilled
> 
> and number of current processes running thru a programme I don't want to
> 
> use system calls and getting info from proc files.I want to display
> 
> these detailes by accessing from sysinfo.Is it possible.Otherwise
> 
> suggest me where i can get related source.
> 
> Thank u all in advance
> 
#include <linux/kernel.h>
#include <linux/sys.h>

struct sysinfo {
long uptime;
unsigned long loads[3];  //machin's load during last minute, last five
min, and last 15 min.
unsigned long totalram;
unsigned long freeram;
unsigned long sharedram;
unsigned long bufferram;
unsigned long totalswap;
unsigned long freeswap;    
unsigned short procs;      //number of process
char[22] _f;              //padding to reach 64 bytes length
}

int sysinfo(struct sysinfo *info);

To browse the source code of open systems is the key :-)

-- 
"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.
--

    Julien Laganier
     Student Intern
Sun Microsystem Laboratories
