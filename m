Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285189AbRL3Ogj>; Sun, 30 Dec 2001 09:36:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285150AbRL3Oga>; Sun, 30 Dec 2001 09:36:30 -0500
Received: from tourian.nerim.net ([62.4.16.79]:42500 "HELO tourian.nerim.net")
	by vger.kernel.org with SMTP id <S284239AbRL3OgP>;
	Sun, 30 Dec 2001 09:36:15 -0500
Message-ID: <3C2F265E.4000105@free.fr>
Date: Sun, 30 Dec 2001 15:36:14 +0100
From: Lionel Bouton <Lionel.Bouton@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20011228
X-Accept-Language: en-us
MIME-Version: 1.0
To: rdicaire@ardynet.com
Cc: Linux <linux-kernel@vger.kernel.org>
Subject: Re: AWE64 Duplex not working with 2.4.17
In-Reply-To: <3C2E0E01.EE3D22D7@ardynet.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rdicaire@ardynet.com wrote:

> I have installed an SB AWE 64, kernel is 2.4.17, audio works fine, but I
> cannot play
> simultaneous multpile wav or mp3 files, errors reported that something
> else has the device open already.
> 


This is an hardware limitation. AWE series don't support multiple PCM 
streams.
So mixing multiple PCM streams must be done in software. Use either esd, 
artsd, ...

You could imagine a driver based software mixing but :
- it would make drivers far more complex -> more bug-prone,
- it may pose performance/feasability problems when your apps need 
accurate timings (Video/audio sync for example).

LB.

