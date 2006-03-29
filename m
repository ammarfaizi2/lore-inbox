Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750945AbWC2J0f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945AbWC2J0f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 04:26:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750972AbWC2J0f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 04:26:35 -0500
Received: from web26908.mail.ukl.yahoo.com ([217.146.176.97]:25766 "HELO
	web26908.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1750943AbWC2J0f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 04:26:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=U6TzTc+Ya/XbTN5MGoTWBSFABlpvbghrxK5dbXCcSXxVXiZ0pCGIlEGySTtY7Vy2U/zFFyyH/pofgOJ2z62+qsldzdBtpYz8qhBFGno/gK4UTei5h9Gz2Mty6WLFpIRWnPj7/WpAoOjSpYhvx1tB4+tLcSveM9VLc/ugXaiCBgM=  ;
Message-ID: <20060329092628.16392.qmail@web26908.mail.ukl.yahoo.com>
Date: Wed, 29 Mar 2006 11:26:28 +0200 (CEST)
From: Etienne Lorrain <etienne_lorrain@yahoo.fr>
Subject: Re: I2C_PCA_ISA causes boot delays (was re: sis96x compiled in by error: delay of one minute at boot)
To: "Mark M. Hoffman" <mhoffman@lightlink.com>
Cc: linux-kernel@vger.kernel.org, lm-sensors <lm-sensors@lm-sensors.org>,
       Ian Campbell <icampbell@arcom.com>
In-Reply-To: <20060329034510.GA8309@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- "Mark M. Hoffman" <mhoffman@lightlink.com> wrote:
> > 885c885
> > < # CONFIG_I2C_PCA_ISA is not set
> > ---
> > > CONFIG_I2C_PCA_ISA=y
> 
> This alone is the cause of the delay.  (I have confirmed it by running some
> similar .configs here.)  You almost certainly don't own this specialized
> piece of hardware.  Worse still, that particular driver has no code to detect
> whether or not the hardware is present.  I cc'ed the listed driver author
> (Ian) just in case this might be corrected... but I guess there is no way
> to fix it.
> 
> So the delay is (1) an I2C bus driver that is not actually present, trying to
> probe for (2) seven different sensors chip drivers that certainly aren't present
> on the nonexistent bus.  Timeouts ensue.
> 
> So unless Ian knows a better way to detect that bus driver... the best I can
> advise is to *not* build in those drivers for hardware that you do not have.

 OK, I know the I2C protocol, and I can imagine a hardware board which does
 not have a way to detect its own presence - or the presence of its own ISA bus.
 What I dislike the most is that, after the driver has taken more than 20
 seconds to probe something it did not find, it did not display anything to
 say "either there is a hardware problem, or you should disable me".
 Are you sure that there isn't any distribution around trying to insert
 _all_ the modules to do hardware detection?
 Note that most I2C driver detect abscence of the hardware in a lot less than
 a second: most of the I2C system is fine.

 Regards,
 Etienne.


	

	
		
___________________________________________________________________________ 
Nouveau : téléphonez moins cher avec Yahoo! Messenger ! Découvez les tarifs exceptionnels pour appeler la France et l'international.
Téléchargez sur http://fr.messenger.yahoo.com
