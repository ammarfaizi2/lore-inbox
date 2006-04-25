Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751386AbWDYHQy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751386AbWDYHQy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 03:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751381AbWDYHQy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 03:16:54 -0400
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:14096 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S1751367AbWDYHQx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 03:16:53 -0400
To: Arjan van de Ven <arjan@infradead.org>
Cc: "Makan Pourzandi (QB/EMC)" <makan.pourzandi@ericsson.com>,
       linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
       Serue Hallyen <serue@us.ibm.com>,
       Axelle Apvrille <axelle_apvrille@rc1.vip.ukl.yahoo.com>,
       disec-devel@lists.sourceforge.net
Subject: Re: [ANNOUNCE] Release Digsig 1.5: kernel module for run-timeauthentication of binaries
References: <6D19CA8D71C89C43A057926FE0D4ADAA29D361@ecamlmw720.eamcs.ericsson.se>
	<1145897277.3116.44.camel@laptopd505.fenrus.org>
	<87hd4ipvdk.fsf@hades.wkstn.nix>
	<1145911526.3116.71.camel@laptopd505.fenrus.org>
	<87zmiao8bq.fsf@hades.wkstn.nix>
	<1145946650.3114.13.camel@laptopd505.fenrus.org>
From: Nix <nix@esperi.org.uk>
X-Emacs: the answer to the world surplus of CPU cycles.
Date: Tue, 25 Apr 2006 08:16:20 +0100
In-Reply-To: <1145946650.3114.13.camel@laptopd505.fenrus.org> (Arjan van de Ven's message of "Tue, 25 Apr 2006 08:30:50 +0200")
Message-ID: <87slo2nn0b.fsf@hades.wkstn.nix>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Apr 2006, Arjan van de Ven prattled cheerily:
> On Tue, 2006-04-25 at 00:35 +0100, Nix wrote:
>> On Mon, 24 Apr 2006, Arjan van de Ven yowled:
>> > On Mon, 2006-04-24 at 21:32 +0100, Nix wrote:
>> >> It checks mmap and mprotect with PROT_EXEC, and execve().
>> > 
>> > so no jvm's or flash plugins.
>> 
>> Well, you'll have to sign the flash plugin. This isn't
>> sign-at-compilation-time; 
> 
> the point I made is that a jvm has executable memory capabilities (it
> has to) and can be made an elf loader. At which point.. game over.

Yeah, you'd have to avoid allowing hostile ELF loaders to execute, but
even they are impeded somewhat: they can't use PROT_EXEC mappings but
have to e.g. use an executable stack hack.

To mix a metaphor badly, it raises the bar; it doesn't burn down the
gym.

>> > so it's not all that easy as you make it sound
>> 
>> Everyone seems to want the One Security Fix To Rule Them All. 
> 
> I'm not part of that "everyone". I'm all in favor of removing degrees of
> freedom. However this one doesn't, it's just pure fake. This is similar
> to posting a sign at your unlocked front door "please don't burgle me
> via my front door" while your windows are also open.

The JVM example is a bit nasty, I'll admit. (Of course I'm safe because
my stripped-down firewall only includes one interpreter, perl, and
that's executable by root only. ;) )

-- 
`On a scale of 1-10, X's "brokenness rating" is 1.1, but that's only
 because bringing Windows into the picture rescaled "brokenness" by
 a factor of 10.' --- Peter da Silva
