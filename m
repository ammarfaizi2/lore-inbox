Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751875AbWAEXoP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751875AbWAEXoP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 18:44:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbWAEXoP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 18:44:15 -0500
Received: from rudy.mif.pg.gda.pl ([153.19.42.16]:4004 "EHLO
	rudy.mif.pg.gda.pl") by vger.kernel.org with ESMTP id S1750750AbWAEXoO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 18:44:14 -0500
Date: Fri, 6 Jan 2006 00:44:02 +0100 (CET)
From: =?ISO-8859-2?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
To: Joern Nettingsmeier <nettings@folkwang-hochschule.de>
cc: Jaroslav Kysela <perex@suse.cz>, Pete Zaitcev <zaitcev@redhat.com>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Adrian Bunk <bunk@stusta.de>, Olivier Galibert <galibert@pobox.com>,
       Tomasz Torcz <zdzichu@irc.pl>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Andi Kleen <ak@suse.de>, ALSA development <alsa-devel@alsa-project.org>,
       James@superbug.demon.co.uk, sailer@ife.ee.ethz.ch,
       linux-sound@vger.kernel.org, zab@zabbo.net, kyle@parisc-linux.org,
       parisc-linux@lists.parisc-linux.org, jgarzik@pobox.com,
       Thorsten Knabe <linux@thorsten-knabe.de>, zwane@commfireservices.com,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [OT] ALSA userspace API complexity
In-Reply-To: <43BDA02F.5070103@folkwang-hochschule.de>
Message-ID: <Pine.BSO.4.63.0601052352110.15077@rudy.mif.pg.gda.pl>
References: <20050726150837.GT3160@stusta.de> <20060103193736.GG3831@stusta.de>
 <Pine.BSO.4.63.0601032210380.29027@rudy.mif.pg.gda.pl>
 <mailman.1136368805.14661.linux-kernel2news@redhat.com>
 <20060104030034.6b780485.zaitcev@redhat.com> <Pine.LNX.4.61.0601041220450.9321@tm8103.perex-int.cz>
 <Pine.BSO.4.63.0601051253550.17086@rudy.mif.pg.gda.pl>
 <Pine.LNX.4.61.0601051305240.10350@tm8103.perex-int.cz>
 <Pine.BSO.4.63.0601051345100.17086@rudy.mif.pg.gda.pl>
 <43BDA02F.5070103@folkwang-hochschule.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-1094550868-1136504642=:15077"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1094550868-1136504642=:15077
Content-Type: TEXT/PLAIN; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT

On Thu, 5 Jan 2006, Joern Nettingsmeier wrote:
[..]
> i look forward to hearing back from you, in, oh, 2015 or so?

Now we have 2006. Four years ALSA is in kernel tree.
2015 - 2006 = 9
4 < 9

Four years ago noone predisct some "temporary sound devices" like BT 
headests in ALSA architecture (bt-sco was developed in 2002 and still 
isn't merged in ALSA tree .. probably because module in current form can't 
provide simple usage like "just plug and play").
This is not matter of any kind prediction because on market four 
years ago was avalaible some "temporary sound devices". BT headsets 
are real and still IIRC there is no way in current ALSA architecture point 
where and how this must plugged.
Why ? Because most of soud stream routing are performed in user space 
library abstraction. For handle this in current ALSA model you must 
prepare EACH application for reciveing signals about for examaple 
changing default soud device (for perform close old and open new). In ALSA 
there is no layer where this kind of redirections can be managed outside 
ALL applications in common and easy way for non-root users

Q: why Linux can't behive as it will have allways soud device with dummy 
device plugged to /dev/null (if only soudcode is loaded) if there is no 
soud hardware in system ? Look .. if you have loaded event module you have 
virtual kbd and mouse .. but real kbd/mouse can be used only afrer load 
keyboard/mouse modules.

Instead try to manage any kind of (even future) devices it will be good if 
ALSA will be ready for manage only current "sound model devices" (like 
mono, stereo, 5.1, 7.1 with simple way for extending set of this profiles) 
but with *moved all sound routing* to kernel space with well defined 
ioctl() or netlink (like in ipfilter) API for manage all configuration 
details (for allow prepare for example cute GUI aplication for manage all 
this for joe users). In this way also will be possible prepare some kernel
level interface for plugging additional modules (or loading external DSO 
modules like in ipfilter for interract with with hardware in any other
way. Apply ipfilter way to soud subsystem can be also used for plugging
filters ..

So .. stop talking about future and start about preset problems. ALSA have 
many problems with current devices (on soud subsystem *architecture level*)

kloczek
-- 
-----------------------------------------------------------
*Ludzie nie maj± problemów, tylko sobie sami je stwarzaj±*
-----------------------------------------------------------
Tomasz K³oczko, sys adm @zie.pg.gda.pl|*e-mail: kloczek@rudy.mif.pg.gda.pl*
--0-1094550868-1136504642=:15077--
