Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161066AbWASHPO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161066AbWASHPO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 02:15:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161067AbWASHPO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 02:15:14 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:44219 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161066AbWASHPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 02:15:13 -0500
Subject: Re: RFC [patch 00/34] PID Virtualization Overview
From: Arjan van de Ven <arjan@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Dave Hansen <haveblue@us.ibm.com>, Suleiman Souhlal <ssouhlal@FreeBSD.org>,
       Serge Hallyn <serue@us.ibm.com>, linux-kernel@vger.kernel.org,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>
In-Reply-To: <1137624867.1760.1.camel@localhost.localdomain>
References: <20060117143258.150807000@sergelap>
	 <43CD18FF.4070006@FreeBSD.org>
	 <1137517698.8091.29.camel@localhost.localdomain>
	 <43CD32F0.9010506@FreeBSD.org>
	 <1137521557.5526.18.camel@localhost.localdomain>
	 <1137522550.14135.76.camel@localhost.localdomain>
	 <1137610912.24321.50.camel@localhost.localdomain>
	 <1137612537.3005.116.camel@laptopd505.fenrus.org>
	 <1137613088.24321.60.camel@localhost.localdomain>
	 <1137624867.1760.1.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 19 Jan 2006 08:15:06 +0100
Message-Id: <1137654906.2993.10.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-18 at 22:54 +0000, Alan Cox wrote:
> On Mer, 2006-01-18 at 11:38 -0800, Dave Hansen wrote:
> > But, it seems that many drivers like to print out pids as a unique
> > identifier for the task.  Should we just let them print those
> > potentially non-unique identifiers, deprecate and kill them, or provide
> > a replacement with something else which is truly unique?
> 
> Pick a format for container number + pid and document/stick with it -
> something like container::pid (eg 0::114) or 114[0] whatever so long as
> it is consistent

having a pid_to_string(<task struct>) or maybe task_to_string() thing
for convenient printing of pids/tasks.. I'm all for that. Means you can
even configure how verbose you want it to be (include ->comm or not,
->state maybe etc)

