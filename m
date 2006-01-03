Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751414AbWACPBw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751414AbWACPBw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 10:01:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751416AbWACPBw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 10:01:52 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:9467 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S1751414AbWACPBv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 10:01:51 -0500
Subject: RE: Latency traces I cannot interpret (sa1100, 2.6.15-rc7-rt1)
From: Daniel Walker <dwalker@mvista.com>
To: kus Kusche Klaus <kus@keba.com>
Cc: Ingo Molnar <mingo@elte.hu>, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <AAD6DA242BC63C488511C611BD51F367323314@MAILIT.keba.co.at>
References: <AAD6DA242BC63C488511C611BD51F367323314@MAILIT.keba.co.at>
Content-Type: text/plain
Date: Tue, 03 Jan 2006 07:01:49 -0800
Message-Id: <1136300510.5915.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-03 at 15:57 +0100, kus Kusche Klaus wrote:
>  Ok, yet another patch. This one uses the correct lowlevel calls, and I
> > fixed the call ordering.
> 
> Hmmm, it changes a few flag and register values (e.g. lr),
> but basically it gives the same BUG and Oops.
> 
> As the first BUG is very early: 
> Is it possible that tracing gets called before it is initialized?

Most likely . It's hard to create a global solution in the entry-*.S
files cause the code in there is called so early.  

Daniel

