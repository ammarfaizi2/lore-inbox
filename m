Return-Path: <linux-kernel-owner+w=401wt.eu-S964987AbWLTK5A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964987AbWLTK5A (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 05:57:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964991AbWLTK47
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 05:56:59 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:39165 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964987AbWLTK46 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 05:56:58 -0500
Subject: Re: [Bug 7505] Linux-2.6.18 fails to boot on AMD64 machine
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Chuck Ebbert <76306.1226@compuserve.com>, Yinghai Lu <yinghai.lu@amd.com>,
       "ard@telegraafnet.nl" <ard@telegraafnet.nl>, take@libero.it,
       agalanin@mera.ru, linux-kernel@vger.kernel.org,
       bugme-daemon@bugzilla.kernel.org,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Zhang Yanmin <yanmin.zhang@intel.com>
In-Reply-To: <20061220023734.863825e1.akpm@osdl.org>
References: <200612200502_MC3-1-D5AF-1674@compuserve.com>
	 <20061220023734.863825e1.akpm@osdl.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Wed, 20 Dec 2006 11:55:58 +0100
Message-Id: <1166612159.3365.1370.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-12-20 at 02:37 -0800, Andrew Morton wrote:
> On Wed, 20 Dec 2006 04:59:19 -0500
> Chuck Ebbert <76306.1226@compuserve.com> wrote:
> 
> > > On 12/19/06, Chuck Ebbert <76306.1226@compuserve.com> wrote:
> > > > So an external interrupt occurred, the system tried to use interrupt
> > > > descriptor #39 decimal (irq 7), but the descriptor was invalid.
> > > 
> > > but the irq is disabled at that time.
> > > 
> > > can you use attached diff to verify if the irq is enable somehow?
> > 
> > But it seems interrupts are on--look at the flags:
> > 
> >         RSP: 0018:ffffffff803cdf68  EFLAGS: 00010246
> > 
> 
> down_write()->__down_write() -> __down_write_nested()->spin_unlock_irq()->dead

since down_write() sleeps..... what?


