Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287764AbSANRVC>; Mon, 14 Jan 2002 12:21:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287794AbSANRUx>; Mon, 14 Jan 2002 12:20:53 -0500
Received: from mout01.kundenserver.de ([195.20.224.132]:22309 "EHLO
	mout01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S287764AbSANRUl>; Mon, 14 Jan 2002 12:20:41 -0500
Date: Mon, 14 Jan 2002 18:20:10 +0100
From: Heinz Diehl <hd@cavy.de>
To: linux-kernel@vger.kernel.org
Cc: Dave Jones <davej@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>,
        mingo@redhat.com
Subject: Re: slowdown with new scheduler.
Message-ID: <20020114172010.GA173@elfie.cavy.de>
Mail-Followup-To: linux-kernel@vger.kernel.org, Dave Jones <davej@suse.de>,
	mingo@redhat.com
In-Reply-To: <20020114124541.A32412@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020114124541.A32412@suse.de>
User-Agent: Mutt/1.3.25-current-20020102i (Linux 2.4.17-h7 i586)
Organization: private site in Mannheim/Germany
X-PGP-Key: To get my public-key, send mail with subject 'get pgpkey'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Jan 14 2002, Dave Jones wrote:

>  After adding H7 to 2.4.18pre3, I noticed that kernel compiles
> on one of my test boxes got much slower.
> Uniprocessor system (Cyrix 3) building a 2.4.18pre3 tree,
> with the same .config, and a distclean before starting the compile.
> 
> 2.4.18pre3        13.38s                       
> 2.4.18pre+H7      17.53s

I did the same; same config, fresh tree, reboot between the test. 
The machine is a (single-processor) AMD K6-2/400 with 256 MB RAM.
Here are the results:

2.4.18-pre3	 	    real    7m55.243s
			    user    6m34.080s
			    sys     0m27.610s

2.4.18-pre+H7		    real    7m35.962s
			    user    6m34.270s
			    sys     0m27.700s

2.4.18-pre3-ac2		    real    7m39.203s
			    user    6m34.110s
			    sys     0m28.740s

Ingo's scheduler rocks, it runs like hell (and is absolutely stable here)  ;)

-- 
# Heinz Diehl, 68259 Mannheim, Germany
