Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281484AbRKUNlC>; Wed, 21 Nov 2001 08:41:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281050AbRKUNkx>; Wed, 21 Nov 2001 08:40:53 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:27152 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S281028AbRKUNkg>; Wed, 21 Nov 2001 08:40:36 -0500
Date: Wed, 21 Nov 2001 14:40:34 +0100
From: Jan Hudec <bulb@ucw.cz>
To: linux-kernel@vger.kernel.org
Subject: Re: [BUG] Bad #define, nonportable C, missing {}
Message-ID: <20011121144034.E2196@artax.karlin.mff.cuni.cz>
Mail-Followup-To: Jan Hudec <bulb@ucw.cz>, linux-kernel@vger.kernel.org
In-Reply-To: <01112112401703.01961@nemo> <20011121133115.A1451@ragnar-hojland.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011121133115.A1451@ragnar-hojland.com>; from ragnar@ragnar-hojland.com on Wed, Nov 21, 2001 at 01:31:15PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Nov 21, 2001 at 12:40:17PM +0000, vda wrote:
> If you wanna do this type of cleanup, you can take it one step forward;
> remember that the order of evaluation of foo and bar doesn't have to be
> {foo => bar} so it can be {bar => foo}  I hope gcc's behaviour doesn't
> change under our feet.
> 
> 	a = foo (i) + bar (j);
> 
> .. sprinkle some pointer arithmetic over there for fun ;)

AFAIK here the order *IS* defined. + operator is evaluated left to right
unless operands are known not to have side-efects (in which case it doesn't
matter). Functions are considered not having side-efects iff they are defined
with constant atribute.

--------------------------------------------------------------------------------
                  				- Jan Hudec `Bulb' <bulb@ucw.cz>
