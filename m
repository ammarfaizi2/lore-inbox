Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbRAEGbo>; Fri, 5 Jan 2001 01:31:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130329AbRAEGbe>; Fri, 5 Jan 2001 01:31:34 -0500
Received: from ganymede.isdn.uiuc.edu ([192.17.19.210]:28167 "EHLO
	ganymede.isdn.uiuc.edu") by vger.kernel.org with ESMTP
	id <S129267AbRAEGbV>; Fri, 5 Jan 2001 01:31:21 -0500
Date: Fri, 5 Jan 2001 00:31:07 -0600
From: Bill Wendling <wendling@ganymede.isdn.uiuc.edu>
To: Keith Owens <kaos@ocs.com.au>
Cc: Miles Lane <miles@megapathdsl.net>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.0ac1
Message-ID: <20010105003107.C19392@ganymede.isdn.uiuc.edu>
In-Reply-To: <3A556195.5090902@megapathdsl.net> <20334.978674744@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20334.978674744@kao2.melbourne.sgi.com>; from kaos@ocs.com.au on Fri, Jan 05, 2001 at 05:05:44PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also sprach Keith Owens:
} On Thu, 04 Jan 2001 21:54:29 -0800, 
} Miles Lane <miles@megapathdsl.net> wrote:
} >make[4]: Entering directory `/usr/src/linux/drivers/acpi'
} >/usr/src/linux/Rules.make:224: *** Recursive variable `CFLAGS' references itself (eventually).  Stop.
} 
} In drivers/acpi/Makefile, delete the line
} 
} $(MODINCL)/%.ver: CFLAGS = -I./include $(CFLAGS)
} 
} You will be able to compile but acpi may not work with module symbol
} versions, so do not select module symbol versions.
} 
Changing that line to:

$(MODINCL)/%.ver: CFLAGS := -I./include $(CFLAGS)

might work as well...

-- 
|| Bill Wendling			wendling@ganymede.isdn.uiuc.edu
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
