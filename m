Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751344AbVK2H1U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbVK2H1U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 02:27:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751345AbVK2H1U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 02:27:20 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:35224 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S1751344AbVK2H1T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 02:27:19 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: Willy Tarreau <willy@w.ods.org>
Subject: Re: [RFC] un petite hack: /proc/*/ctl
Date: Tue, 29 Nov 2005 09:26:24 +0200
User-Agent: KMail/1.8.2
Cc: Alexey Dobriyan <adobriyan@gmail.com>, Chris Boot <bootc@bootc.net>,
       linux-kernel@vger.kernel.org
References: <20051129002801.GA9785@mipter.zuzino.mipt.ru> <20051129054819.GR11266@alpha.home.local> <20051129055310.GS11266@alpha.home.local>
In-Reply-To: <20051129055310.GS11266@alpha.home.local>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511290926.24833.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 29 November 2005 07:53, Willy Tarreau wrote:
> On Tue, Nov 29, 2005 at 06:48:19AM +0100, Willy Tarreau wrote:
> > On Tue, Nov 29, 2005 at 04:33:54AM +0300, Alexey Dobriyan wrote:
> > > On Tue, Nov 29, 2005 at 12:23:19AM +0000, Chris Boot wrote:
> > > > On 29 Nov 2005, at 0:28, Alexey Dobriyan wrote:
> > > > >echo kill >/proc/$PID/ctl
> > > > >	send SIGKILL to process
> > > > >
> > > > >echo term >/proc/$PID/ctl
> > > > >	send SIGTERM to process
> >
> > so please don't pollute the list with useless patches that take time
> > to review.
> 
> Sorry, I've just noticed that you marked the subject "[RFC]" and not
> "[PATCH]". Anyway I still find it useless :-)

It's just fits into "Everything is a file" and 
eliminates the need of a kill syscall.

Needs to be complemented with means to do
kill 0 ("All processesin the current process group are signaled"),
kill -1 ("All processes with pid larger than 1 are signaled") and
kill -n ("All processes in process group n are signaled").
--
vda
