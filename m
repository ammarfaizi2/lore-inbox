Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262817AbUJ1IBj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262817AbUJ1IBj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 04:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262818AbUJ1IBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 04:01:39 -0400
Received: from canuck.infradead.org ([205.233.218.70]:10762 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S262817AbUJ1IAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 04:00:51 -0400
Subject: Re: ext3 multiple thread streaming write performance with 2.6.9
From: Arjan van de Ven <arjan@infradead.org>
To: Shantanu Goel <sgoel01@yahoo.com>
Cc: Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20041028040421.80505.qmail@web12826.mail.yahoo.com>
References: <20041028040421.80505.qmail@web12826.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1098950444.2642.6.camel@laptop.fenrus.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Thu, 28 Oct 2004 10:00:45 +0200
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.6 (++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (2.6 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[62.195.31.207 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[62.195.31.207 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-27 at 21:04 -0700, Shantanu Goel wrote:
> Hi,
> 
> I am seeing extremely variable and poor performance
> with ext3 in the presence of multiple streaming
> writers.  Below are the results of some tests I have
> conducted with iozone.  XFS appears to be most
> consistent performer for this workload, followed by
> ext2 and finally ext3.  Has this been observed
> elsewhere?  If so, is it possible to tune ext3 to
> perform better on this workload?

yes you should use the reservations patch from the -mm tree;
see http://people.redhat.com/arjanv/reservations.png for a graph of the difference 

