Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755206AbWKMXpk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755206AbWKMXpk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 18:45:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755373AbWKMXpk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 18:45:40 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:37542 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1755206AbWKMXpj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 18:45:39 -0500
Subject: Re: [RFC] Pushing device/driver binding decisions to userspace
From: Lee Revell <rlrevell@joe-job.com>
To: Jim Crilly <jim@why.dont.jablowme.net>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Ben Collins <ben.collins@ubuntu.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20061113232241.GH4824@voodoo.jdc.home>
References: <1163374762.5178.285.camel@gullible>
	 <1163404727.15249.99.camel@laptopd505.fenrus.org>
	 <1163443887.5313.27.camel@mindpipe>
	 <1163449139.15249.197.camel@laptopd505.fenrus.org>
	 <20061113221611.GG4824@voodoo.jdc.home> <1163458748.5313.74.camel@mindpipe>
	 <20061113232241.GH4824@voodoo.jdc.home>
Content-Type: text/plain
Date: Mon, 13 Nov 2006 18:45:01 -0500
Message-Id: <1163461501.8780.2.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-11-13 at 18:22 -0500, Jim Crilly wrote:
> Well it doesn't and the only error I get from the game is:
> 
> /dev/dsp: Input/output error
> Could not mmap /dev/dsp
> 
> If it makes a difference, lspci lists the card as:
> 
> 00:04.0 Multimedia audio controller: nVidia Corporation CK804 AC'97
> Audio Controller (rev a2) 

Please see http://www.alsa-project.org/~iwai/OSS-Emulation.html.

You need something like:

$ echo "quake 0 0 direct" > /proc/asound/card0/pcm0p/oss

Lee

