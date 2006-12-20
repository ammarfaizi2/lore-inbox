Return-Path: <linux-kernel-owner+w=401wt.eu-S965092AbWLTOcH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965092AbWLTOcH (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 09:32:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965094AbWLTOcH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 09:32:07 -0500
Received: from styx.suse.cz ([82.119.242.94]:44588 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S965092AbWLTOcG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 09:32:06 -0500
X-Greylist: delayed 1961 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Dec 2006 09:32:05 EST
Date: Wed, 20 Dec 2006 15:00:09 +0100
From: Jiri Benc <jbenc@suse.cz>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: Network drivers that don't suspend on interface down
Message-ID: <20061220150009.1d697f15@griffin.suse.cz>
In-Reply-To: <20061220125314.GA24188@srcf.ucam.org>
References: <20061219185223.GA13256@srcf.ucam.org>
	<200612191959.43019.david-b@pacbell.net>
	<20061220042648.GA19814@srcf.ucam.org>
	<200612192114.49920.david-b@pacbell.net>
	<20061220053417.GA29877@suse.de>
	<20061220055209.GA20483@srcf.ucam.org>
	<1166601025.3365.1345.camel@laptopd505.fenrus.org>
	<20061220125314.GA24188@srcf.ucam.org>
X-Mailer: Sylpheed-Claws 2.5.5 (GTK+ 2.10.6; x86_64-suse-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Dec 2006 12:53:14 +0000, Matthew Garrett wrote:
> The situation is more complicated for wireless. Userspace expects to be 
> able to get scan results from the card even if the interface is down.

User space should get an error when trying to get scan results from the
interface that is down. Some drivers are broken and don't do this but
when they're fixed there is no problem here.

> In that case, I'm pretty sure we need a third state rather than just
> "up" or "down".

We have that third state, it's IFF_DORMANT. Not supported yet by any
wireless driver/stack, unfortunately.

Thanks,

 Jiri

-- 
Jiri Benc
SUSE Labs
