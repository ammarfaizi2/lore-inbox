Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262117AbVBXHqj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262117AbVBXHqj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 02:46:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262121AbVBXHoS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 02:44:18 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:5084 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S261890AbVBXHmY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 02:42:24 -0500
Subject: Re: [Lse-tech] Re: A common layer for Accounting packages
From: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
To: Jay Lan <jlan@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, Kaigai Kohei <kaigai@ak.jp.nec.com>,
       LSE-Tech <lse-tech@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       erikj@subway.americas.sgi.com, limin@dbear.engr.sgi.com,
       jbarnes@sgi.com, elsa-devel <elsa-devel@lists.sourceforge.net>
In-Reply-To: <421CD570.7070907@sgi.com>
References: <42168D9E.1010900@sgi.com>
	 <20050218171610.757ba9c9.akpm@osdl.org> <421993A2.4020308@ak.jp.nec.com>
	 <421B955A.9060000@sgi.com> <421C2B99.2040600@ak.jp.nec.com>
	 <20050222232002.4d934465.akpm@osdl.org>
	 <1109147623.1738.91.camel@frecb000711.frec.bull.fr>
	 <421CD570.7070907@sgi.com>
Date: Thu, 24 Feb 2005 08:42:23 +0100
Message-Id: <1109230943.1738.169.camel@frecb000711.frec.bull.fr>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 24/02/2005 08:51:17,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 24/02/2005 08:51:20,
	Serialize complete at 24/02/2005 08:51:20
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-02-23 at 11:11 -0800, Jay Lan wrote:
> Guillaume Thouvenin wrote:
> > It's what I'm proposing. The problem is to be alerted when a new process
> > is created in order to add it in the correct group of processes if the
> > parent belongs to one (or several) groups. The notification can be done
> > with the fork connector patch. 
> 
> I am not quite comfortable of ELSA requesting a fork hook this way.
> How many hooks in the stock kernel that are related to accounting? Can
> anyone answer this question? I know of 'acct_process()' in exit.c used
> by the BSD accounting and ELSA is requesting a hook in fork. If people
> raise the same question again a few years later, how many people will
> still remember this ELSA hook?

  The fork connector is not related to accounting. It's a connector that
allows to send information to a user space application when a fork
occurs in the kernel.

  This information is used by ELSA by I think that this hook will be
used by some others user space applications and IMHO, it's not
incompatible with a specific hook for accounting tool if needed.

Guillaume

