Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266431AbTAIMnE>; Thu, 9 Jan 2003 07:43:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266456AbTAIMnE>; Thu, 9 Jan 2003 07:43:04 -0500
Received: from oak.sktc.net ([208.46.69.4]:9151 "EHLO oak.sktc.net")
	by vger.kernel.org with ESMTP id <S266431AbTAIMnD>;
	Thu, 9 Jan 2003 07:43:03 -0500
Message-ID: <3E1D705E.1030203@sktc.net>
Date: Thu, 09 Jan 2003 06:51:42 -0600
From: "David D. Hagood" <wowbagger@sktc.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021201
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Wolfgang Fritz <wolfgang.fritz@gmx.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: [Asterisk] DTMF noise
References: <D6889804-2291-11D7-901B-000393950CC2@karlsbakk.net> <3E1BD88A.4080808@users.sf.net> <3E1C1CDE.8090600@sktc.net> <3E1C4872.7080508@gmx.net>
In-Reply-To: <3E1C4872.7080508@gmx.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wolfgang Fritz wrote:

> Maybe it would be better to reenable harmonic checks but comparing
> harmonic levels to the level of the fundamental instead of using
> absolute values as in the present implementation.

You mean the code DOESN'T normalize the signal to the total energy 
first?!?!? YEEP!

The very FIRST thing you do is compute the total signal energy in the 
sample period, trivially reject if Etotal < MinETotal, then normalize 
all other signal energies to Etotal - that is a basic tenant of DSP.


> standard test procedure with a lot of test cases which are not available 
> to mortal humans (audio tapes from Bellcore IIRC)

I think we may have the test cases as WAVs at work, and I think they are 
freely distributable - I'll kick a reminder to my work account off to 
check later today.


