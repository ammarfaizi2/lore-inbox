Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422784AbWCXHzn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422784AbWCXHzn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 02:55:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422785AbWCXHzm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 02:55:42 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:670 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1422784AbWCXHzl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 02:55:41 -0500
Subject: Re: [2.6.16 PATCH] Connector: Filesystem Events Connector v3
From: Arjan van de Ven <arjan@infradead.org>
To: CaT <cat@zip.com.au>
Cc: Andrew Morton <akpm@osdl.org>, "David S. Miller" <davem@davemloft.net>,
       yang.y.yi@gmail.com, linux-kernel@vger.kernel.org, johnpol@2ka.mipt.ru,
       matthltc@us.ibm.com
In-Reply-To: <20060324075245.GY2057@zip.com.au>
References: <1143183541.2882.7.camel@laptopd505.fenrus.org>
	 <20060323.230649.11516073.davem@davemloft.net>
	 <20060323232345.1ca16f3f.akpm@osdl.org>
	 <20060323.232903.34304885.davem@davemloft.net>
	 <20060323234200.19e7eb54.akpm@osdl.org>  <20060324075245.GY2057@zip.com.au>
Content-Type: text/plain
Date: Fri, 24 Mar 2006 08:55:31 +0100
Message-Id: <1143186931.2882.16.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-24 at 18:52 +1100, CaT wrote:
> On Thu, Mar 23, 2006 at 11:42:00PM -0800, Andrew Morton wrote:
> > You explained why it was better than grafting audit onto this application. 
> > 
> > But do you see some special value in the actual services which this patch
> > provides - monitoring filesystem events?
> 
> Is there something around atm that would, for example, allow a virus
> scanner to scan files when they are created, etc? Or to add files to
> an index for quick searches?

audit, inotify


> There are probably other potential uses but I'm too tired and those two
> come to mind right now.

but this mechanism doesn't actually cover the virus scanner need at
least; audit is a bit more complex in code because it's a security tool
and needs to be accurate for security-related events. Now guess what...
a virus scanner needs this same level of scrutiny... (well unless you
don't care about that it's easy to bypass your scanner and that you
support linux only for marketing reasons ;)


