Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318976AbSICXUb>; Tue, 3 Sep 2002 19:20:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318968AbSICXUb>; Tue, 3 Sep 2002 19:20:31 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:16369
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318937AbSICXUa>; Tue, 3 Sep 2002 19:20:30 -0400
Subject: Re: aic7xxx sets CDR offline, how to reset?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Patrick Mansfield <patmans@us.ibm.com>,
       "Justin T. Gibbs" <gibbs@scsiguy.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
In-Reply-To: <200209032202.g83M2mC09323@localhost.localdomain>
References: <200209032202.g83M2mC09323@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 04 Sep 2002 00:26:45 +0100
Message-Id: <1031095605.21579.44.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-09-03 at 23:02, James Bottomley wrote:
> > And what happens if one command gets some sort of check condition
> > (like medium error, or aborted command) that causes a retry? Will IO's
> > still be correctly ordered? 
> 
> Retries get eliminated.  It should be up to the upper layers (sd or beyond) to 
> say whether a retry is done.  Since, as you point out, retries automatically 
> violate any barrier, it is probably up to the block layer to judge what should 
> be done about the problem.

Then we need to give the block layer a lot more information about what
kind of a problem occurred

