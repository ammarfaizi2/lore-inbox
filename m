Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261623AbTCTRta>; Thu, 20 Mar 2003 12:49:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261625AbTCTRta>; Thu, 20 Mar 2003 12:49:30 -0500
Received: from mail.alacritech.com ([12.44.162.38]:28427 "HELO
	mail.alacritech.com") by vger.kernel.org with SMTP
	id <S261623AbTCTRt2>; Thu, 20 Mar 2003 12:49:28 -0500
Subject: Re: [patch] 2.5.65-mjb1: lkcd: EXTRA_TARGETS is obsolete
From: "Matt D. Robinson" <yakker@alacritech.com>
To: Sam Ravnborg <sam@ravnborg.org>,
       "Matt D. Robinson" <yakker@alacritech.com>
Cc: Adrian Bunk <bunk@fs.tum.de>, "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030319211704.GA1030@mars.ravnborg.org>
References: <8230000.1047975763@[10.10.2.4]>
	 <20030319153304.GC23258@fs.tum.de>
	 <20030319211704.GA1030@mars.ravnborg.org>
Content-Type: text/plain
Organization: Alacritech, Inc.
Message-Id: <1048183433.17271.0.camel@lambda.alacritech.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 20 Mar 2003 10:03:54 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When you have the final patch done, send it along so I can
incorporate it into our main CVS tree.  We went down this
kerntypes.o issue a while ago when trying to get into the
tree the first time.  Thanks.

--Matt

On Wed, 2003-03-19 at 13:17, Sam Ravnborg wrote:
> On Wed, Mar 19, 2003 at 04:33:04PM +0100, Adrian Bunk wrote:
> > 
> > EXTRA_TARGETS is obsolete in 2.5.
> > 
> > The following should do the same:
> > 
> > +obj-$(CONFIG_CRASH_DUMP)	+= kerntypes.o
> 
> As Andrew pointed out this is wrong.
> Use the following notation:
> +extra-$(CONFIG_CRASH_DUMP)	+= kerntypes.o
> 
> This way of selecting extra .o files is the reason to have the "-y"
> in extra-y.
> 
> 	Sam
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

