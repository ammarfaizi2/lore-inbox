Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263435AbTLOIEc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 03:04:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263452AbTLOIEc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 03:04:32 -0500
Received: from [62.12.131.37] ([62.12.131.37]:21680 "HELO debian")
	by vger.kernel.org with SMTP id S263435AbTLOIE3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 03:04:29 -0500
Date: Mon, 15 Dec 2003 09:04:27 +0100
From: "Zeno R.R. Davatz" <zdavatz@ywesee.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: alsa on gentoo ppc 2.6.0-test11-benh1
Message-Id: <20031215090427.7071fc29.zdavatz@ywesee.com>
In-Reply-To: <1071474131.12496.411.camel@gaston>
References: <20031212083609.6db56e5b.zdavatz@ywesee.com>
	<1071474131.12496.411.camel@gaston>
Organization: ywesee - intellectual capital connected
X-Mailer: Sylpheed version 0.9.7claws (GTK+ 1.2.10; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Dec 2003 18:42:12 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> 
> It seems you are trying to load both dmasound_pmac and alsa
> snd-powermac, they are mutually exclusive.
my modules.autoload.d/kernel-2.6 looks like this:
# For example:
# 3c59x
#soundcore
#dmasound_pmac
hcfusbserial
hcfusbengine
hcfusbosspec
serial
snd
snd-powermac

But sudo /etc/init.d/alsasound restart still gives me:

 * WARNING:  you are stopping a boot service.
 * Unloading ALSA...
 * Storing ALSA Mixer Levels
/usr/sbin/alsactl: save_state:1061: No soundcards found...
 * Unloading modules                                                                                                                                       [ ok ] * Loading ALSA drivers...
 * Loading: snd-mixer-oss
 * Loading: snd-pcm-oss
 * Loading: snd-seq-oss
 * Loading: snd-powermac
FATAL: Error inserting snd_powermac (/lib/modules/2.6.0-test11-benh1/kernel/sound/ppc/snd-powermac.ko): No such device
 * Loading: snd-seq-oss
FATAL: Module snd_seq_oss already in kernel.
 * Running card-dependent scripts
 * Restoring Mixer Levels                        

TIA
Zeno

-- 
Mit freundlichen Grüssen / best regards

Zeno Davatz
Verkauf & Akquisition

+41 1 350 85 86

www.ywesee.com > intellectual capital connected > www.oddb.org
