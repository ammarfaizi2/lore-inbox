Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263005AbVEHX0Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263005AbVEHX0Y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 19:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263003AbVEHX0Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 19:26:24 -0400
Received: from smtp04.auna.com ([62.81.186.14]:60832 "EHLO smtp04.retemail.es")
	by vger.kernel.org with ESMTP id S263005AbVEHX0L convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 19:26:11 -0400
Date: Sun, 08 May 2005 23:24:40 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: 2.6.12-rc3-mm3: ALSA broken ?
To: linux-kernel@vger.kernel.org
References: <20050504221057.1e02a402.akpm@osdl.org>
	<1115510869l.7472l.0l@werewolf.able.es>
In-Reply-To: <1115510869l.7472l.0l@werewolf.able.es> (from
	jamagallon@able.es on Sun May  8 02:07:49 2005)
X-Mailer: Balsa 2.3.1
Message-Id: <1115594680l.7540l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 05.08, J.A. Magallon wrote:
> 
> On 05.05, Andrew Morton wrote:
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc3/2.6.12-rc3-mm3/
> > 
> > - device mapper updates
> > 
> > - more UML updates
> > 
> > - -mm seems unusually stable at present.
> > 
> 
> Ehem, is ALSA broken ?
> 
> I can't spread stereo output to 4 channel. More specific, I can't switch
> one of my female jacks between in and out.
> 
> Long explanation: I have an
> 
> 00:1f.5 Multimedia audio controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) AC'97 Audio Controller (rev 02)
> 
> It has three outputs. One is always output, for normal stereo or front in 4
> channel. One other is LineIn/Back-for-4-channel. And the third is
> Mic/Bass-Center.
> 
> In 2.6.11 I have two
> toggles in ALSA: 'Spread front to center...' and 'surround jack as input'
> Adjusting both I could get to duplicate the output in the Back jack.
> In 2.6.12-rc3-mm3 there is no way to get this working.
> 

I have just tested in 2.6.12-rc4 and works fine. I even feed the stereo
signal to the 6 channels, so 4 go to my desktop speaker system and one
other pair to may home stereo.

Something is broken in -mm wrt ALSA. If you need me to test some specific
version, pleas just ask.

Side note: trying to load settings from rc4 in -mm says:

alsactl: set_control:930: warning: name mismatch (Surround Jack as Input/Surround Jack Mode) for control #42
alsactl: set_control:932: warning: index mismatch (0/0) for control #42
alsactl: set_control:1030: bad control.42.value type

Hope this helps.

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandriva Linux release 2006.0 (Cooker) for i586
Linux 2.6.11-jam16 (gcc 4.0.0 (4.0.0-3mdk for Mandriva Linux release 2006.0))


