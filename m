Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261463AbVARXIK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261463AbVARXIK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 18:08:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261468AbVARXIK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 18:08:10 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:64510 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261463AbVARXHy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 18:07:54 -0500
Subject: Re: [PATCH 1/1] tpm: fix cause of SMP stack traces
From: Kylene Hall <kjhall@us.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, Emily Ratliff <emilyr@us.ibm.com>,
       Tom Lendacky <toml@us.ibm.com>, tpmdd-devel@lists.sourceforge.net
In-Reply-To: <20050118224753.GA17547@kroah.com>
References: <Pine.LNX.4.58.0412081546470.24510@jo.austin.ibm.com>
	 <Pine.LNX.4.58.0412161632200.4219@jo.austin.ibm.com>
	 <Pine.LNX.4.58.0412171642570.9229@jo.austin.ibm.com>
	 <Pine.LNX.4.58.0412201146060.10943@jo.austin.ibm.com>
	 <29495f1d041221085144b08901@mail.gmail.com>
	 <Pine.LNX.4.58.0412211209410.14092@jo.austin.ibm.com>
	 <Pine.LNX.4.58.0501121236180.2453@jo.austin.ibm.com>
	 <Pine.LNX.4.58.0501181621200.2473@jo.austin.ibm.com>
	 <20050118224753.GA17547@kroah.com>
Content-Type: text/plain
Message-Id: <1106089670.2324.16.camel@jo.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 18 Jan 2005 17:07:50 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-01-18 at 16:47, Greg KH wrote:
> On Tue, Jan 18, 2005 at 04:29:23PM -0600, Kylene Hall wrote:
> > There were misplaced spinlock acquires and releases in the probe, open, 
> > close and release paths which were causing might_sleep and schedule while 
> > atomic error messages accompanied by stack traces when the kernel was 
> > compiled with SMP support. Bug reported by Reben Jenster 
> > <ruben@hotheads.de>
> 
> Where exactly where the trace errors coming from?  I don't see anything
> in the open path that might have caused it.
> 
True the open path was not affected.
> Anyway, Chris is right, just changing this to _irqsave will not fix the
> issue.
Fixing will reissue the patch momentarily.
> 
> thanks,
> 
> greg k-h
> 

