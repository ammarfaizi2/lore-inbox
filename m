Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317418AbSGTOwN>; Sat, 20 Jul 2002 10:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317419AbSGTOwM>; Sat, 20 Jul 2002 10:52:12 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:27146 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S317418AbSGTOwM>; Sat, 20 Jul 2002 10:52:12 -0400
Date: Sat, 20 Jul 2002 16:55:04 +0200
From: Tomas Szepe <szepe@dragon.cz>
To: Daniel Phillips <phillips@arcor.de>
Cc: Ville Herva <vherva@niksula.hut.fi>,
       Thunder from the hill <thunder@ngforever.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH -ac] Panicking in morse code, v2
Message-ID: <20020720145504.GD7333@louise.pinerecords.com>
References: <E17Vrwh-0000b5-00@starship> <Pine.LNX.4.44.0207200518480.3378-100000@hawkeye.luckynet.adm> <20020720132234.GF1548@niksula.cs.hut.fi> <E17Vv4I-0000kh-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E17Vv4I-0000kh-00@starship>
User-Agent: Mutt/1.4i
X-OS: GNU/Linux 2.4.19-pre10/sparc SMP
X-Uptime: 45 days, 7:34
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Hi,
> > > 
> > > On Sat, 20 Jul 2002, Daniel Phillips wrote:
> > > > Unfortunately, this code is too useful to ignore.
> > > 
> > > I think it's also a nice-to-have for 2.5.
> > 
> > Okay, maybe it's just me being too lazy and ignorant to teach myself morse
> > code...
> 
> Then teach it to a script, call it "unmorse" ;-)
> 
> 	echo dit dit dit dah dah dah dit dit dit | unmorse

Try this on for size:


/*  dorssel.c, 1998 IOCCC entry
 *  Frans van Dorsselaer <frans@biabv.com>
 */

#include<stdio.h>
#include<string.h>

main()
{
	char*O,l[999]="'`acgo\177~|xp .-\0R^8)NJ6%K4O+A2M(*0ID57$3G1FBL";
	while(O=fgets(l+45,954,stdin)){
		*l=O[strlen(O)[O-1]=0,strspn(O,l+11)];
		while(*O)switch((*l&&isalnum(*O))-!*l){
		case-1:{char*I=(O+=strspn(O,l+12)+1)-2,O=34;
			while(*I&3&&(O=(O-16<<1)+*I---'-')<80);
			putchar(O&93?*I&8||!(I=memchr(l,O,44))?'?':I-l+47:32);
			break;
		case 1:	;}*l=(*O&31)[l-15+(*O>61)*32];
			while(putchar(45+*l%2),(*l=*l+32>>1)>35);
		case 0:	putchar((++O,32));}
	putchar(10);}
}
