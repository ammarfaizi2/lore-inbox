Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750972AbWC2Jo1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750972AbWC2Jo1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 04:44:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750969AbWC2Jo1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 04:44:27 -0500
Received: from wproxy.gmail.com ([64.233.184.228]:47957 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750826AbWC2Jo0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 04:44:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=nP2qCQvtya7ETI+iy45Jj+fRP1B2+gsRT77gAt7I4QjKCAspcofiSmNbvcGcIMhiCHEoTCA3h62PA+GLEBJpzNqpT7i/UF2YygD8qS3cHqcvpwDcitQxhFF2uDtkMjM/joIhIa0rDhlZ10ZoGODVJ+Qsp0r94qsKwke1+ZGJIR8=
Date: Wed, 29 Mar 2006 11:44:19 +0200
From: Frederik Deweerdt <deweerdt@free.fr>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.16-mm2] Kconfig SND_SEQUENCER_OSS help text fix
Message-ID: <20060329094419.GA9446@silenus.home.res>
References: <20060328003508.2b79c050.akpm@osdl.org> <20060328134654.GA9671@silenus.home.res> <1143617782.442a38f61b98b@www.domainfactory-webmail.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1143617782.442a38f61b98b@www.domainfactory-webmail.de>
User-Agent: mutt-ng/devel-r790 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2006 at 10:36:22AM +0200, Clemens Ladisch wrote:
> The help test is misleading, but partly true.
The text itself is thus a tristate: "true, false, partly true" :)
> 
> > - To compile this driver as a module, choose M here: the module
> > - will be called snd-seq-oss.
> 
> It is not possible to choose M here, but the OSS sequencer will be a
> module when the ALSA sequencer (CONFIG_SND_SEQUENCER) is a module.
> 
Could we settle for this?


Signed-off-by: Frederik Deweerdt <frederik.deweerdt@gmail.com>

--- linux-2.6.16-mm2/sound/core/Kconfig~	2006-03-29 11:08:33.000000000 +0200
+++ linux-2.6.16-mm2/sound/core/Kconfig	2006-03-29 11:27:23.000000000 +0200
@@ -92,8 +92,9 @@
 
 	  Many programs still use the OSS API, so say Y.
 
-	  To compile this driver as a module, choose M here: the module
-	  will be called snd-seq-oss.
+	  If you choosed M in "Sequencer support" (SND_SEQUENCER),
+	  this will be compiled as a module. The module will be called
+	  snd-mixer-oss.
 
 config SND_RTCTIMER
 	tristate "RTC Timer support"
