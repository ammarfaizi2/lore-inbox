Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751248AbWEFGuS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248AbWEFGuS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 May 2006 02:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbWEFGuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 May 2006 02:50:18 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:13229 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S1751248AbWEFGuQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 May 2006 02:50:16 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: Re: [RFC] kernel facilities for cache prefetching
Date: Sat, 6 May 2006 09:49:31 +0300
User-Agent: KMail/1.8.2
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Jens Axboe <axboe@suse.de>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Badari Pulavarty <pbadari@us.ibm.com>
References: <20060502075049.GA5000@mail.ustc.edu.cn> <1146558617.32045.23.camel@laptopd505.fenrus.org> <346559990.12674@ustc.edu.cn>
In-Reply-To: <346559990.12674@ustc.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605060949.31990.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 02 May 2006 11:53, Wu Fengguang wrote:
> On Tue, May 02, 2006 at 10:30:17AM +0200, Arjan van de Ven wrote:
> > one interesting thing that came out of the fedora readahead work is that
> > most of the bootup isn't actually IO bound. My test machine for example
> > can load all the data into ram in about 10 seconds, so that the rest of
> > the boot is basically IO-less. But that still takes 2 minutes....
> > So I'm not entirely sure how much you can win by just attacking this.
> 
> Yes, I find it hard to improve the boot time of the init.d stage.

Then _get rid of your init.d_.

SysV init sequence is insane.

I use daemontools-based setup and it starts up to login prompt
in 5-10 secs (counting from the root fs mount).

In my setup, after a few simple startup scripts a svscan process
is called, which starts all services in parallel.
Gettys are services, and start right away.
--
vda
